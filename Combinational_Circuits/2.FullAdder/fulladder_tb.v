`timescale 1ns/1ps

module fulladder_tb;
    reg p,q,r;
    wire sum,c_out;

    fulladder uut (.a(p),.b(q),.c(r),.s(sum),.cout(c_out));
    
    initial
    begin
        $dumpfile("fulladder.vcd");
        $dumpvars(0,fulladder_tb);
        $monitor("Time=%0t|a=%b|b=%b|c=%b|sum=%b|cout=%b",$time,p,q,r,sum,c_out);
        p=0;q=0;r=0;#10;
        p=0;q=0;r=1;#10;
        p=0;q=1;r=0;#10;
        p=0;q=1;r=1;#10;
        p=1;q=0;r=0;#10;
        p=1;q=0;r=1;#10;
        p=1;q=1;r=0;#10;
        p=1;q=1;r=1;#10;

    end

endmodule