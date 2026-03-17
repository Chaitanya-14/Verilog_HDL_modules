`timescale 1ns/1ps
module vending_machine_tb;
    reg clk, rst,in1,in2;
    wire x_out, y_out;

    vending_machine uut (.clk(clk),.rst(rst),.co_in0(in1),.co_in1(in2),.x_out(x_out),.y_out(y_out));
    
    parameter CYCLE = 10;

    initial
    clk = 1'b0;
    always #(CYCLE /2) clk = ~clk;
    
    task delay;
        input k;
        begin
            #k;
        end
    endtask

    task initialise;
        begin
            rst = 1'b0;
            in1 = 1'b0;
            in2 = 1'b0;
            dealy(1);
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

    task stimulus;
        input tin1;
        input tin2;
        begin
            @(posedge clk);
            in1 = tin1;
            #1
            in2 = tin2;
            #1
        end
    endtask

    
