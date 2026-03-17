`timescale 1ns/1ps
module vending_machine_tb;
    reg clk, rst,in1,in2;
    wire x_out, y_out;

    vending_machine uut (.clk(clk),.rst(rst),.co_in0(in1),.co_in1(in2),.x_out(x_out),.y_out(y_out));
    
    parameter CYCLE = 10;

    initial begin
        clk = 1'b0;
    end
    always #(CYCLE /2) clk = ~clk;
    
    task delay;
        input integer k;
        begin
            #k;
        end
    endtask

    task initialise;
        begin
            rst = 1'b0;
            in1 = 1'b0;
            in2 = 1'b0;
            delay(1);
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
            in2 = tin2;
            @(posedge clk);

            in1 = 1'b0;
            in2 = 1'b0;
        end
    endtask

    initial
        begin
            $monitor("$Time = %0t | coin1= %b | coin 2 =%b | x_out = %b | y_out = %b", $time, in1 , in2 , x_out, y_out);
            $dumpfile("vending_machine.vcd");
            $dumpvars(0,vending_machine_tb);
        end

    initial
        begin
            initialise;
            delay (5);
            rst_dut;
            $display(" Dropping 1 Rs Coin ");
            stimulus (1,0); 
            $display("Dropping another 1 Rs Coin");
            stimulus (1,0); 
            $display("--- Dropping 2 Rs Coin ---");
            stimulus (1,1); 
            delay (50);
            $finish;
        
        
        
        end
endmodule

