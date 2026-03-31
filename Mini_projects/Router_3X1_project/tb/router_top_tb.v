/*

File_name   : router_top_tb.v

Description : This testbench drives a packet with payload_length = 14 bytes.

Author Name : Chaitanya Roy

Version     : 1.0 

*/

module router_top_tb;
    //global variables
    reg clock;
    reg resetn;
    reg read_enb_0;
    reg read_enb_1;
    reg read_enb_2;
    reg [7:0] data_in;
    reg pkt_valid;

    //output
    wire [7:0] data_out_0;
    wire [7:0] data_out_1;
    wire [7:0] data_out_2;
    wire valid_out_0;
    wire valid_out_1;
    wire valid_out_2;
    wire error;
    wire busy;

    //integer variable for iteration within for loop
    integer i;

    parameter CYCLE = 10;

    //Router Top instance
    router_top dut (clock,
                    resetn,
                    read_enb_0,
                    read_enb_1,
                    read_enb_2,
                    data_in,
                    pkt_valid,
                    data_out_0,
                    data_out_1,
                    data_out_2,
                    valid_out_0,
                    valid_out_1,
                    valid_out_2,
                    error,
                    busy);


    //clock generation code
    initial
    begin
    clock = 1'b0;
    end
    always #(CYCLE/2) clock = ~clock;

    //reset task
    task rst_dut;
        begin
            @(negedge clock);
                resetn = 1'b0;
            @(negedge clock);
                resetn = 1'b1;
        end
    endtask

    // packet with payload length : 14 bytes
    task pkt_gen_14;
    reg [7:0] payload_data , parity , header;
    reg [5:0] payload_len;
    reg [1:0] addr;
        begin
            @(negedge clock);
            wait(~busy)
            @(negedge clock);
            payload_len = 6'd14;
            addr = 2'b01;
            header = {payload_len , addr};
            parity = 0;
            data_in = header;
            pkt_valid = 1;
            parity = parity ^ header;
            @(negedge clock);
            wait(~busy);
            for (i=0;i<payload_len;i=i+1)
                begin
                    @(negedge clock);
                    wait(~busy);
                    payload_data = {$random} % 256;
                    data_in = payload_data;
                    parity = parity ^ payload_data;                
                end
            @(negedge clock);
            wait(~busy);
            pkt_valid = 0;
            data_in = parity;
        end
    endtask

    // stimulus block
    initial
        begin
            rst_dut;
            repeat(3) @(negedge clock);
            pkt_gen_14;
            repeat(2) @(negedge clock);
            read_enb_1 = 1;
            wait(~valid_out_1);
            @(negedge clock);
            read_enb_1 = 0;
            #1000 $finish;
        end
endmodule