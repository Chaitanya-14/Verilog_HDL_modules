`timescale 1ns/1ps

module simple_not_tb;
    reg a;
    wire f;

    simple_not uut (.a(a),.f(f));

    initial begin
    //for gtk wave
    $dumpfile("simplenot.vcd"); //create vcd file
    $dumpvars(0,simple_not_tb); //dump the variables

    $monitor("time = %0t | a=%b | f=%b",$time,a,f); // to monitor the values

    //truth table
    a=0; #10;
    a=1; #10;

    $finish;
    end

endmodule