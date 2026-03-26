module router_reg(  input clock,
                    input resetn,
                    input pkt_valid,
                    input [7:0] data_in,
                    input fifo_full,
                    input rst_int_reg,
                    input detect_addr,
                    input ld_state,
                    input laf_state,
                    input full_state,
                    input lfd_state,
                    output reg parity_done,
                    output reg low_pkt_valid,
                    output reg err,
                    output  reg [7:0] dout);
                    
//internal registers
reg [7:0] full_state_byte; 
reg [7:0] pkt_parity;
reg [7:0] first_byte;
reg [7:0] internal_parity;


// parity done logic
always @(posedge clock)
    begin
        if (~resetn)
            parity_done <= 1'b0;
        else if ((ld_state && !fifo_full && !pkt_valid) || (laf_state && !parity_done && low_pkt_valid)) // it will be asserted only when packet parity is recieved from source lan within the register block
            parity_done <=  1'b1;
        else if (detect_addr)
            partiy_done <= 1'b0; //parity done is initialised when new address is detected
    end







endmodule