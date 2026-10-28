`timescale 1ns/1ns

module fulladder_tb;

    reg atb;
    reg btb;
    reg cintb;

    wire sum;
    wire cout;

    full_adder uut (.a(atb),.b(btb),.c(cintb),.sum_out(sum),.c_out(cout));
    

    initial
    begin
        $dumpfile("full_adder.vcd");
        $dumpvars(0,fulladder_tb);
        $monitor("Time = %0t | a=%b , b=%b , c=%b | sum=%b carry out=%b",$time,atb,btb,cintb,sum,cout);
        
        //exhaustive testing
        atb=0 ; btb=0 ; cintb=0; #10;
        atb=0 ; btb=0 ; cintb=1; #10;
        atb=0 ; btb=1 ; cintb=0; #10;
        atb=0 ; btb=1 ; cintb=1; #10;
        atb=1 ; btb=0 ; cintb=0; #10;
        atb=1 ; btb=0 ; cintb=1; #10;
        atb=1 ; btb=1 ; cintb=0; #10;
        atb=1 ; btb=1 ; cintb=1; #10;

        $finish;
    end

endmodule
