module router_sync # (parameter FIFO1 = 3'b001  FIFO2 = 3'b010  FIFO3 = 3'b100 )
                    (input clock,
                    input resetn,
                    input detect_addr,
                    input [1:0] data_in,
                    input write_enb_reg,
                    input read_enb_0,
                    input read_enb_1,
                    input read_enb_2,
                    input empty_0,
                    input empty_1,
                    input empty_2,
                    input full_0,
                    input full_1,
                    input full_2,
                    output [2:0] write_enb,
                    output fifo_full,
                    output valid_out_0,
                    output valid_out_1,
                    output valid_out_2,
                    output soft_reset_0,
                    output soft_reset_1,
                    output soft_reset_2, );

// internal register
reg [1:0] addr;
reg [4:0] count_read_0;
reg [4:0] count_read_1;
reg [4:0] count_read_2;


// address logic
always @ (posedge clock)
    begin
        if (detect_addr)
            addr <= data_in;            
    end

// write enable logic
always @ (*)
    begin
        if (~write_enb_reg) // comes from FSM if it is low, then don't write to any FIFO, 
            write_enb = 0;
        else 
            begin
                case(addr)
                    2'b00 : write_enb = FIFO1;
                    2'b01 : write_enb = FIFO2;
                    2'b10 : write_enb = FIFO3;
                    default : write_enb = 0; // if the address is 2'b11
                endcase
            end
    end


// valid out logic
assign valid_out_0 = ~empty;
assign valid_out_1 = ~empty;
assign valid_out_2 = ~empty;





endmodule