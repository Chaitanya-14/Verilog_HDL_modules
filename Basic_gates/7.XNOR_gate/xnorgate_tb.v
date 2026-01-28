`timescale 1ns / 1ns // Time unit: 1ns, Time precision: 1ns

module xnorgate_tb;
    reg a,b;
    wire f;

    xnorgate uut (.a(a),.b(b),.f(f));

    initial
    begin
        $dumpfile("xnorgate.vcd");
        $dumpvars(0,xnorgate_tb);
        $monitor("Time=%0t|a=%b|b=%b|f=%b",$time,a,b,f);
        a=0;b=0;#10;
        a=0;b=1;#10;
        a=1;b=0;#10;
        a=1;b=1;#10;
        $finish;
    end
endmodule