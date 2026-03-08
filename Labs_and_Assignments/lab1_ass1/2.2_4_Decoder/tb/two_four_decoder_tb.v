`timescale 1ns/1ps
module two_four_decoder_tb;
    reg [1:0] a;
    wire [3:0] out;

    two_four_decoder uut (.a(a),.out(out));

    initial
    begin 
        $monitor ("Time = %0t| a=%b | out=%b",$time, a,out);
        $dumpfile("two_four_decoder.vcd");
        $dumpvars(0, two_four_decoder_tb);

        #10 a = 2'b00;
        #10 a = 2'b01;
        #10 a = 2'b10;
        #10 a = 2'b11;
        #10 $finish;
    end
endmodule
