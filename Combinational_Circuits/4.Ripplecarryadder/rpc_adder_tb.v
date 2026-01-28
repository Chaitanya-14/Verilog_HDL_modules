`timescale 1ns / 1ps;

module rpc_adder_tb;

    reg [3:0] a,b;
    reg cin;
    wire [3:0] s;
    wire cout;

    rpc_adder uut (.a(a),.b(b),.cin(cin),.s(s),.cout(cout));

    initial 
    begin
        $dumpfile("rpc_adder.vcd");
        $dumpvars(0,rpc_adder_tb);
        $monitor ("t=0%t | a=%b | b = %b | cin = %b| s=%b| cout=%b",$time,a,b,cin,s,cout);
        #10
        a = 4'b1011 ; b= 4'b1111; cin = 0;

        #10 $finish;

    end
endmodule
