`timescale 1ns/1ps
module siso_4bit_tb;
    reg clk,rst,serial_in;
    wire serial_out;

    siso_4bit uut (
    .clk(clk),
    .rst(rst),
    .serial_in(serial_in),
    .serial_out(serial_out));

    task initialise;
        begin
            rst = 1'b0;
            serial_in = 1'b0;
        end
    endtask

    initial
    clk = 1'b0;
    always #5 clk = ~clk;

    task serialin;
        input tin;
        begin
            serial_in = tin;
            #1;
        end
    endtask

    task delay;
        begin
            #10;
        end
    endtask

    task rst_dut;
        begin
            rst = 1'b1;
            #10;
            rst = 1'b0;
        end
    endtask 


    initial
        begin
            $dumpfile("siso_4bit_tb.vcd");
            $dumpvars(0, siso_4bit_tb);
            $monitor("Time=%0t clk=%b rst=%b serial_in=%b serial_out=%b", $time, clk, rst, serial_in, serial_out);
            initialise;
            rst_dut;
            serialin(1'b1);
            delay;
            serialin(1'b0);
            delay;
            serialin(1'b1);
            delay;
            serialin(1'b0);
            delay;
            serialin(1'b1);
            $finish;
        end
    
endmodule
            
            