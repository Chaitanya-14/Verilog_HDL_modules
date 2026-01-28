`timescale 1ns/1ps;


module half_sub_tb;
    reg a,b;
    wire d,bo;

    half_sub uut (.a(a),.b(b),.d(d),.bo(bo));

    initial 
    begin
        $dumpfile("half_sub.vcd");
        $dumpvars(0,half_sub_tb);
        $monitor("t=0%t | a=%b | b=%b | d=%b| bo=%b ", $time, a,b,d,bo);
        #10
        #10 a=0;b=0;
        #10 a=0;b=1;
        #10 a=1;b=0;
        #10 a=1;b=1;
        #10 $finish;
end
endmodule