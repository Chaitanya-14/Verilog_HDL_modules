`timescale 1ns/1ns

module nandgate_tb;

    reg a,b;
    wire f;

    nandgate uut (.a(a),.b(b),.f(f));

    initial
    begin
        $dumpfile("nandgate.vcd");
        $dumpvars(0,nandgate_tb);
        $monitor("Time = %0t|a=%b|b=%b|f=%b",$time,a,b,f);

        a=0;b=0;#10;
        a=0;b=1;#10;
        a=1;b=0;#10;
        a=1;b=1;#10;
        $finish;
    end
endmodule

