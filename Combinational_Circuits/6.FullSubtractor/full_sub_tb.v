`timescale 1ns/1ps;

module full_sub_tb;
    reg a,b,c;
    wire d,bo;

    full_sub uut (.a(a),.b(b),.c(c),.d(d),.bo(bo));

    initial 
    begin 
        $dumpfile("full_sub.vcd");
        $dumpvars(0,full_sub_tb);
        $monitor("t=0%t | a=%b | b=%b | c=%b | d=%b | bo=%b ",$time,a,b,c,d,bo);
        #10
        #10 a=0;b=0;c=0;
        #10 a=0;b=0;c=1;
        #10 a=0;b=1;c=0;
        #10 a=0;b=1;c=1;
        #10 a=1;b=0;c=0;
        #10 a=1;b=0;c=1;
        #10 a=1;b=1;c=0;
        #10 a=1;b=1;c=1;
        #10 $finish;
    end
endmodule
