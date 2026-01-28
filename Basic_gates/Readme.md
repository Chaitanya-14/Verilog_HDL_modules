# Verilog Simulation Workflow

## Step 1: Create Source Files
Ensure you have your Design file and Testbench file ready in the same directory.

- **Design File**: `simple_and.v` (The hardware logic)
- **Testbench**: `simple_and_tb.v` (The verification script)

---

## Step 2: Compile the Design
Use `iverilog` to verify syntax and link the modules together. This creates an executable simulation file.

```bash
iverilog -o mysim simple_and.v simple_and_tb.v
```

- `-o mysim`: Names the output executable `mysim`.

If no errors appear, the compilation was successful.

---

## Step 3: Run the Simulation
Execute the compiled file using the `vvp` runtime engine. This prints the output to the terminal and generates the `.vcd` file for waveforms.

```bash
vvp mysim
```

- **Terminal Output**: You will see your `$display` or `$monitor` logs here.
- **File Output**: A file named `simpleand.vcd` (or whatever name you defined in `$dumpfile` inside your testbench) is created.

---

## Step 4: Visualize Waveforms
Open the Value Change Dump (`.vcd`) file using GTKWave to see the timing diagram.

```bash
gtkwave simpleand.vcd
```

### ⚠️ GTKWave Troubleshooting: Screen is Black / Blank?
If GTKWave opens but shows no signals, follow these steps to load them manually:

1. **Find the Hierarchy**: Look at the left panel labeled `SST`. Click the `+` icon next to `simpleand_tb`.
2. **Select the Module**: Click on `uut` (Unit Under Test) or `simpleand_tb`.
3. **Select Signals**: In the list below, you will see your signals (e.g., `a`, `b`, `f`).
    - Click the first signal, hold `Shift`, and click the last signal to select all.
4. **Add to Graph**: Drag the selected signals into the black area, or click the "Append" / "Insert" button.
5. **Zoom Out**: If the lines look flat or you can't see changes:
    - Click the **Zoom Fit** icon (🔍 with a square `[ ]`).
    - Or press the shortcut: `Cmd + Option + F`.