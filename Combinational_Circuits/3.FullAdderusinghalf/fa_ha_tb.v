`timescale 1ns /1ps;

module fa_ha_tb;
    reg a,b,cin;
    wire s,cout;

    fa_ha uut (.a(a),.b(b),.cin(cin),.s(s),.cout(cout));

    initial 
        begin
            $dumpfile("fa_ha.vcd");
            $dumpvars(0,fa_ha_tb);
            $monitor ("t=%0t | a=%b | b=%b | cin=%b | s = %b | cout =%b",$time,a,b,cin,s,cout);
            #10
            a=0;b=0;cin=0;#10
            a=0;b=0;cin=1;#10
            a=0;b=1;cin=0;#10
            a=0;b=1;cin=1;#10
            a=1;b=0;cin=0;#10
            a=1;b=0;cin=1;#10
            a=1;b=1;cin=0;#10
            a=1;b=1;cin=1;#10
            #10 $finish;
        end

endmodule