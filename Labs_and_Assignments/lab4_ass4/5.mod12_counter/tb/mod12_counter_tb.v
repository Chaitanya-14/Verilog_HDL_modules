`timescale 1ns/1ps
module mod12_counter_tb;
    reg clk,rst,load_en,count_en;
    reg [3:0] data_in;
    wire [3:0] data_out;

    mod12_counter uut (.clk(clk) ,.rst(rst), .load_en(load_en), .count_en(count_en), .data_in(data_in) ,.data_out(data_out));

    task initialise;
        begin
            rst = 1'b0;
            load_en = 1'b0;
            count_en = 1'b0;
            data_in = 4'b0000;
        end
    endtask

    initial
    clk = 1'b0;
    always #5 clk = ~clk;

    task rst_dut;
        begin
            @(negedge clk)
            rst = 1'b1;
            @(negedge clk)
            rst = 1'b0;
        end
    endtask

    task do_load;
        input tld;
        input [3:0] tdata;
        begin
            count_en = 1'b0;
            load_en = tld;
            data_in = tdata;
            @(posedge clk);
            #1;
        end
    endtask

    task do_count();
        begin
            load_en = 1'b0;
            count_en = 1'b1;
            @(posedge clk);
            #1;
        end
    endtask

    initial
        begin
            $dumpfile("mod12_counter.vcd");
            $dumpvars(0,mod12_counter_tb);
            $monitor("Time=%0t rst=%b load_en=%b count_en=%b data_in=%b data_out=%b",$time,rst,load_en,count_en,data_in,data_out);
            initialise;
            rst_dut;
            do_count;
            do_count;
            do_count;
            do_load(1'b1,4'b1010);
            do_count;
            do_count;
            #100 $finish;
        end
endmodule