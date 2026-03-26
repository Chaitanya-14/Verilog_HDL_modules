`timescale 1ns/1ps
module router_reg_tb;
// global variables
    reg clock;
    reg reset;
    reg pkt_valid;
    reg [7:0] data_in;
    reg fifo_full;
    reg rst_int_reg;
    reg detect_addr;
    reg ld_state;
    reg laf_state;
    reg full_state;
    reg lfd_state;
    wire parity_done;
    wire low_pkt_valid;
    wire err;
    wire [7:0] dout;

    parameter CYCLE = 10;

    integer i; // for interation in the for loop

    // instantiation
    router_reg dut (.clock(clock),
                    .reset(reset),
                    .pkt_valid(pkt_valid),
                    .data_in(data_in),
                    .fifo_full(fifo_full),
                    .rst_int_reg(rst_int_reg),
                    .detect_addr(detect_addr),
                    .ld_state(ld_state),
                    .laf_state(laf_state),
                    .full_state(full_state),
                    .lfd_state(lfd_state),
                    .parity_done(parity_done),
                    .low_pkt_valid(low_pkt_valid),
                    .err(err),
                    .dout(dout));

    // clock generation logic
    initial
    clock = 1'b0;
    always #(CYCLE/2)  clock = ~clock;

    // reset task
    task rst_dut;
        begin
            @(negedge clock);
                resetn = 1'b0;
            @(negedge clock);
                resetn = 1'b1;
                #1;
        end
    endtask

    // intitalisation of input values
    task initialise;
        begin
            (pkt_valid,fifo_full,rst_int_reg,detect_addr,ld_state,laf_state,full_state,lfd_state,data_in) = 0;
        end 
    endtask

    //good packet generation task
    task good_packet; // where we expect the err to be 0
        reg [7:0] header,payload_data,parity;
        reg [5:0] payload_len;
        reg [1:0] addr;
            begin
                @(negedge clock)
                    payload_len = 6'd3;
                    addr = 2'b10; //valid packet
                    pkt_valid = 1'b1;
                    detect_addr = 1'b1;
                    header = {payload_len,addr};
                    parity = 0^header;
                    data_in = header;
                @(negedge clock)
                    detect_addr = 1'b0;
                    lfd_state = 1'b1;
                    full_state = 1'b0;
                    fifo_full = 1'b0;
                    laf_state = 1'b0;
                    for(i=0;i<payload_len;i=i+1)
                        begin
                            @(negedge clock)
                                lfd_state = 1'b0;
                                ld_state = 1'b1;
                                payload_data = {$random} %256;
                                data_in = payload_data;
                                parity = parity ^ data_in; // parity is generated on each enw payload generated
                        end
                @(negedge clock)
                    pkt_valid = 1'b0;
                    data_in = parity;
                @(negedge clock)
                    ld_state = 1'b0;               
            end
    endtask

    //bad packet generation task where the parity is mismatched
    task bad_packet;
        reg [7:0] header,payload_data,parity;
        reg [5:0] payload_len;
        reg [1:0] addr;
        begin
            @(negedge clock)
                payload_len = 6'd3;
                addr = 1'b01; // valid address and packet
                pkt_valid = 1'b1;
                detect_addr = 1'b1;
                header = {payload_len,addr};
                partiy = 0^header;
                data_in = header;
            @(negedge clock)
                detect_addr = 0;
                lfd_state = 1'b1;
                full_state = 0;
                fifo_full= 0;
                laf_state = 0;
                for (i=0;i<payload_len;i=i+1)
                    begin
                        lfd_state = 1'b0;
                        ld_state = 1'b1;
                        payload_data = {$random} % 256;
                        data_in = payload_data;
                        parity = parity ^ payload_data;
                    end
            @(negedge clock)
                pkt_valid = 1'b0;
                data_in = ~parity;
            @(negedge clock)
                ld_state = 1'b0;
        end
    endtask

    // stimulus task
    initial
        begin
            initialise;
            rst_dut;
            good_packet;
            bad_packet;
            #1000 $finish;
        end    

endmodule
