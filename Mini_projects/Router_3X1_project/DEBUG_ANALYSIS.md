# Router FIFO High Impedance & Count Issue - Root Cause Analysis

## Problem Summary
- **Symptom 1**: High impedance (8'hzz) appearing on `data_out` when it shouldn't
- **Symptom 2**: Count is not starting (never detecting header byte)
- **Root Cause**: Header byte is not being written to FIFO with the header flag (lfd_state) set to 1

---

## Timeline Analysis

### Cycle N: LOAD_FIRST_DATA State
```
FSM: present_state = LOAD_FIRST_DATA
lfd_state = 1
ld_state = 0
write_enb_reg = 0 (NOT ENABLED for write)

router_reg.v dout update:
  else if (lfd_state)           ← THIS BRANCH EXECUTES
    dout <= first_byte;          ← first_byte is loaded to dout

FIFO write:
  write_enb = 0 (from router_sync) 
  NO WRITE OCCURS TO FIFO
```

### Cycle N+1: LOAD_DATA State
```
FSM: present_state = LOAD_DATA
lfd_state = 0 (NOW LOW!)
ld_state = 1
write_enb_reg = 1 (ENABLED for write)

router_reg.v dout update:
  else if (ld_state && !fifo_full)  ← THIS BRANCH EXECUTES NOW
    dout <= data_in;                 ← first_byte is OVERWRITTEN with data_in!

FIFO write occurs:
  mem[wr_ptr[3:0]] <= {lfd_state, data_in};
                       ↑ This is 0 now! (lfd_state already went low)
                       ↑ data_in is the FIRST PAYLOAD BYTE, not the header!
  
Result: WRONG BYTE WRITTEN WITH WRONG FLAG
```

---

## Issues Identified

### **Issue #1: The Delayed Flag is NOT Being Used** ⚠️ CRITICAL
In `router_fifo.v`, you created `lfd_state_d1` but never used it:

```verilog
reg lfd_state_d1;
always@(posedge clock)
  lfd_state_d1 <= lfd_state;

// ... but in the write logic:
mem[wr_ptr[3:0]] <= {lfd_state, data_in};  // ← Still using original lfd_state!
                     ↑ This won't work - lfd_state is already 0 during actual write
```

### **Issue #2: First Byte is Not Preserved on dout**
The `dout` in `router_reg.v` is overwritten before the write occurs:

```verilog
// Cycle N (LOAD_FIRST_DATA): dout = first_byte
// Cycle N+1 (LOAD_DATA): dout ← data_in (first_byte is LOST!)
```

### **Issue #3: Write Enable Not Active During Header Load**
`write_enb_reg` is only high during LOAD_DATA, LOAD_AFTER_FULL, LOAD_PARITY.
It's **NOT** high during LOAD_FIRST_DATA, so header byte is never written.

### **Issue #4: Reading Detects No Header**
Since the header byte was never written with `lfd_state=1`, when reading:

```verilog
if (mem[rd_ptr[3:0]][8] == 1'b1)  // ← Always FALSE!
    count <= mem[rd_ptr[3:0]][7:2] + 1'b1;
else if (count != 0)
    count <= count - 1'b1;
```

Count stays at 0, so `data_out` stays in high impedance:
```verilog
if ((count == 0) && (data_out != 0))
    data_out <= 8'hzz;  // ← This executes when count never starts!
```

---

## The Fix (Multi-part)

### **Fix #1: Use the Delayed lfd_state** (In router_fifo.v)
Change the write logic to use `lfd_state_d1`:
```verilog
// CHANGE THIS:
mem[wr_ptr[3:0]] <= {lfd_state, data_in};

// TO THIS:
mem[wr_ptr[3:0]] <= {lfd_state_d1, data_in};
```

### **Fix #2: Preserve First Byte on dout** (In router_reg.v)
Add a register to hold the first_byte state and keep it on dout during write:

```verilog
reg hold_first_byte;

// Track when we're in first data load
always@(posedge clock)
    begin
        if(~resetn)
            hold_first_byte <= 1'b0;
        else if(lfd_state)
            hold_first_byte <= 1'b1;
        else if(ld_state && !fifo_full && hold_first_byte)
            hold_first_byte <= 1'b0;  // Clear after first write
    end

// Keep first_byte on dout for one more cycle
always@(posedge clock)
    begin
        if (~resetn)
            dout <= 8'h00;
        else begin 
            if (detect_addr && pkt_valid == 1 && data_in[1:0] != 2'b11)
                first_byte <= data_in;
            else if (lfd_state)
                dout <= first_byte;
            else if (ld_state && !fifo_full) 
                begin
                    if(hold_first_byte)  // ← Keep outputting first_byte on first write
                        dout <= first_byte;  
                    else
                        dout <= data_in;
                end
            else if(ld_state && fifo_full)
                full_state_byte <= data_in;
            else if (laf_state)
                dout <= full_state_byte;
        end
    end
```

### **Fix #3: Enable Write During Header Load** (Alternative Approach)
Modify `router_fsm.v` to enable write earlier:
```verilog
assign write_enb_reg = ((present_state == `LOAD_FIRST_DATA) || 
                        (present_state == `LOAD_DATA) || 
                        (present_state == `LOAD_AFTER_FULL) || 
                        (present_state == `LOAD_PARITY)) ? 1'b1 : 1'b0;
```

---

## Recommended Solution

Implement **Fix #1 + Fix #2** together:
1. Use `lfd_state_d1` to align the header flag with actual write time
2. Preserve `first_byte` on `dout` for proper data flow

This ensures:
- First byte is written with header flag set (bit[8] = 1)
- Reader detects header and initializes count
- Data output is valid, not high impedance
