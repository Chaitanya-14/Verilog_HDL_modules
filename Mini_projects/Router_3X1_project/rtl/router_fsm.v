// --- state definitions ---
`define DECODE_ADDRESS      4'd0
`define LOAD_FIRST_DATA     4'd1
`define LOAD_DATA           4'd2
`define LOAD_PARITY         4'd3
`define FIFO_FULL_STATE     4'd4
`define LOAD_AFTER_FULL     4'd5
`define WAIT_TILL_EMPTY     4'd6
`define CHECK_PARITY_ERROR  4'd7

module router_fsm ( input clock,
                    input resetn,
                    input pkt_valid,
                    input [1:0]data_in,
                    input parity_done,
                    input fifo_full,
                    input soft_reset_0,
                    input soft_reset_1,
                    input soft_reset_2,
                    input low_pkt_valid,
                    input fifo_empty_0,
                    input fifo_empty_1,
                    input fifo_empty_2,

                    output busy,
                    output detect_addr,
                    output ld_state,
                    output laf_state,
                    output full_state,
                    output write_enb_reg,
                    output rst_int_reg,
                    output lfd_state   );

// internal registers
reg [2:0] present_state;
reg [2:0] next_state;
reg [1:0] data_temp_addr;

// address logic
always@(posedge clock)
    begin
        if (detect_addr)
            data_temp_addr <= data_in; // same logic as in shynchroniser storing in internal register
    end

// present state logic
always@(posedge clock)
    begin
        if(~resetn)
            present_state <=  `DECODE_ADDRESS;
        else if (((data_temp_addr == 0) & soft_reset_0) | ((data_temp_addr == 1) & soft_reset_1) | ((data_temp_addr == 2) & soft_reset_2))
            present_state <= `DECODE_ADDRESS;    //timeout logic, if addr = 0/1/2 and soft reset is 1 the return to DECODE ADDRESS 
                                            // the timeout correcponds to the spesific address  
        else 
            present_state <= next_state;
    end


// next state comb logic
always@(*) // to make sure there is no latch, we use * - all the events are included in sensitivity list
    begin
        next_state = `DECODE_ADDRESS;
            case(present_state)
                `DECODE_ADDRESS : begin
                                        if (pkt_valid == 1 && (data_in[1:0] == 2'b00))
                                            begin
                                                if (fifo_empty_0)
                                                    next_state = `LOAD_FIRST_DATA;
                                                else
                                                    next_state = `WAIT_TILL_EMPTY;
                                            end
                                        else if (pkt_valid == 1 && (data_in[1:0]== 2'b01))
                                            begin
                                                if (fifo_empty_1)
                                                    next_state = `LOAD_FIRST_DATA;
                                                else
                                                    next_state = `WAIT_TILL_EMPTY;
                                            end
                                        else if (pkt_valid == 1 && (data_in[1:0] == 2'b10))
                                            begin
                                                if (fifo_empty_2)
                                                    next_state = `LOAD_FIRST_DATA;
                                                else
                                                    next_state = `WAIT_TILL_EMPTY;
                                            end
                                        else 
                                            next_state = `DECODE_ADDRESS;
                                    end

                `LOAD_FIRST_DATA : begin
                                        next_state = `LOAD_DATA;
                                    end
                `LOAD_DATA       : begin
                                        if (fifo_full == 1'b1)
                                            next_state = `FIFO_FULL_STATE;
                                        else if (pkt_valid == 1'b0)
                                            next_state = `LOAD_PARITY;
                                        else
                                            next_state = `LOAD_DATA;
                                    end
                `LOAD_PARITY     : begin
                                        next_state = `CHECK_PARITY_ERROR;
                                    end
                `FIFO_FULL_STATE : begin
                                        if (fifo_full == 1'b1)
                                            next_state = `FIFO_FULL_STATE;
                                        else 
                                            next_state = `LOAD_AFTER_FULL;
                                    end
                `LOAD_AFTER_FULL : begin
                                        if (parity_done == 1'b1)
                                            next_state = `DECODE_ADDRESS;
                                        else if (low_pkt_valid == 1'b1)
                                            next_state = `LOAD_PARITY;
                                        else 
                                            next_state = `LOAD_DATA;
                                        end
                `WAIT_TILL_EMPTY : begin
                                        if ((~fifo_empty_0 && (data_temp_addr == 0)) | (~fifo_empty_1 && (data_temp_addr == 1)) | (~fifo_empty_2 && (data_temp_addr == 2)))
                                            begin
                                                next_state = `WAIT_TILL_EMPTY;
                                            end
                                        else
                                            begin
                                                next_state = `LOAD_FIRST_DATA;
                                            end
                                    end
                `CHECK_PARITY_ERROR : begin
                                            if (~fifo_full)
                                                next_state = `DECODE_ADDRESS;
                                            else 
                                                next_state = `FIFO_FULL_STATE;
                                      end
            endcase
    end

//output logic
assign detect_addr      = (present_state == `DECODE_ADDRESS) ? 1'b1 : 1'b0;
assign lfd_state        = (present_state == `LOAD_FIRST_DATA) ? 1'b1 : 1'b0;
assign ld_state         = (present_state == `LOAD_DATA) ? 1'b1 : 1'b0;
assign full_state       = (present_state == `FIFO_FULL_STATE) ?   1'b1 : 1'b0;
assign laf_state         = (present_state == `LOAD_AFTER_FULL) ? 1'b1 : 1'b0;
assign write_enb_reg    = ((present_state == `LOAD_DATA) || (present_state == `LOAD_AFTER_FULL) || (present_state == `LOAD_PARITY)) ? 1'b1 : 1'b0;
assign busy             = ((present_state == `FIFO_FULL_STATE) || (present_state == `LOAD_FIRST_DATA) || (present_state == `LOAD_AFTER_FULL) || (present_state == `LOAD_PARITY) || 
                             (present_state == `CHECK_PARITY_ERROR) || (present_state == `WAIT_TILL_EMPTY)) ? 1'b1 : 1'b0;



endmodule