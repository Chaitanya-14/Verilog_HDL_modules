`timescale 1ns/1ns

module simple_nor_tb;

    reg a,b;
    wire f;

    norgate uut (.a(a),.b(b),.f(f));

    initial
    begin
        $dumpfile("simple_nor.vcd");
        $dumpvars(0,simple_nor_tb);
        $monitor("Time =0%t | a=%b | b=%b | f=%b",$time,a,b,f);

        a=0 ; b=0; #10;
        a=0;b=1; #10;
        a=1;b=0; #10;
        a=1;b=1; #10;
        $finish;
    end
endmodule