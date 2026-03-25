`timescale 1ns/1ps
module router_fifo_tb;
    reg clock,resetn,soft_reset,write_enb,read_enb,lfd_state;
    reg [7:0] data_in;
    wire full,empty;
    wire [8:0] data_out;
    integer i;

    parameter CYCLE = 10;

    router_fifo uut (.clock(clock),.resetn(resetn),.write_enb(write_enb),.read_enb(read_enb),.soft_reset(soft_reset),.data_in(data_in),.data_out(data_out),.full(full),.empty(empty),.lfd_state(lfd_state));

    // clock initialisation
    initial begin
    clock = 1'b0;
    end
    always #(CYCLE/2) clock = ~clock;

    // initialisation task
    task initialise;
        begin
            write_enb=0;
            read_enb=0;
            lfd_state = 0;
            data_in =0;
        end
    endtask

    //reset task
    task rst_dut;
        begin
            @(negedge clock);
                resetn = 1'b0;
            @(negedge clock);
                resetn = 1'b1;
            #1;
        end
    endtask

    // soft reset task
    task soft_rst_dut;
        begin
            @(negedge clock);
                soft_reset = 1'b1;
            @(negedge clock);
                soft_reset = 1'b0;
            #1;
        end
    endtask

    // packet generation task
    task pkt_gen;
        reg [7:0] payload_data,parity,header;
        reg [5:0] payload_length;
        reg [1:0] address;
            begin
                @(negedge clock);
                    payload_length = 6'd4;
                    address = 2'b01;
                    header = {payload_length,address};
                    data_in = header;
                    lfd_state = 1'b1;
                    write_enb = 1'b1;
                    for (i=0;i<payload_length;i=i+1)
                        begin
                            @(negedge clock);
                                lfd_state=0;
                                payload_data = ($random) %256;
                                data_in = payload_data;
                        end
                    @(negedge clock);
                        parity = ($random)%256;
                        data_in = parity;
            end
    endtask

    // read task
    task read;
        input tread;
        begin
            @(negedge clock);
                read_enb = tread;
                #1;
        end
    endtask

    initial
        begin
            initialise;
            rst_dut;
            soft_rst_dut;
            pkt_gen;    //packet wil be generated
            @(negedge clock);
            write_enb=0;
            repeat(5)
            @(negedge clock);
            read(1'b1);
            @(negedge clock);
            wait(empty);
            @(negedge clock);
            read(1'b0);
            #1000 $finish;
        end
    
    initial
        begin
            $dumpfile("router_fifo.vcd");
            $dumpvars(0,router_fifo_tb);
            $monitor("Values are data in = %b , data_out = %b , full = %b , empty = %b",data_in,data_out,full,empty);
        end
endmodule
