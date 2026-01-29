`timescale 1ns/1ps;

module ha_nand_tb;
    reg a,b;
    wire s,cout;

    ha_nand uut (.a(a),.b,.s(s),.cout(cout));

    initial
    begin
        $dumpfile("ha_nand.vcd");
        $dumpvars(0,ha_nand_tb);
        $monitor("t=0%t | a=%b | b=%b | s=%b | cout=%b ",$time,a,b,s,cout);
        #10
        #10 a=0;b=0;
        #10 a=0;b=1;
        #10 a=1;b=0;
        #10 a=1;b=1;
        #10 $finish;

    end
endmodule
