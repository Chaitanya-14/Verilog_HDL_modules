`timescale 1ns/1ps
module counter_up_down_tb;
    reg clk,rst,load_en,count_en,mode;
    reg [3:0] data_in;
    wire [3:0] data_out;

    counter_up_down uut (.clk(clk), .rst(rst), .load_en(load_en), .count_en(count_en), .mode(mode), .data_in(data_in), .data_out(data_out));

    initial
    clk = 1'b0;
    always #5 clk = ~clk;

    task initialise;
    begin
        rst = 1'b0;
        load_en = 1'b0;
        count_en = 1'b0; 
        data_in = 4'b0000;
        mode = 1'b0;
    end
    endtask

    task rst_dut;
        begin
            @(negedge clk);
                rst = 1'b1;
            @(negedge clk);
                rst = 1'b0;
        end
    endtask

    task do_load;
        input tld;
        input [3:0] t_data;
        begin
            load_en = tld;
            count_en = 1'b0;
            data_in = t_data;
            @(posedge clk);
            #1;
        end
    endtask

    task do_count;
        input tm;
        begin  
            load_en = 1'b0;
            count_en = 1'b1;
            mode = tm;
            @(posedge clk);
            #1;
        end
    endtask

    initial
        begin
            $dumpfile("counter_up_down.vcd");
            $dumpvars(0,counter_up_down_tb);
            $monitor("Time = %0t rst=%b load_en=%b count_en=%b mode=%b data_in=%b data_out=%b",$time,rst,load_en,count_en,mode,data_in,data_out);
            initialise;
            rst_dut;
            do_count(1'b0);
            do_count(1'b0);
            do_count(1'b0);
            do_count(1'b0);
            do_count(1'b0);
            do_load(1'b1,4'b0101);
            do_count(1'b1);
            do_count(1'b1);
            do_count(1'b1);
            do_count(1'b1);
            do_count(1'b1);
            do_count(1'b0);
            do_count(1'b0);
            do_count(1'b0);
            do_count(1'b0);
            #100 $finish;
        end
endmodule






