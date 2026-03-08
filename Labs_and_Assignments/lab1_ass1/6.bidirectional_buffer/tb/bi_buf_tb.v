`timescale 1ns / 1ps
module bi_buf_tb;
    reg x_in,y_in;
    wire x_out,y_outl;
    reg c;
    integer i,j,k;
    bi_buf uut1 (.x_in(x_in),.y_in(y_in),.x_out(x_out),.y_out(y_out),.c(c));

    task apply_stimulus;
        input [1:0] txin,[1:0] tyin;
        input [1:0] tc;
    initial
    begin
        $monitor("time=%0t c=%b x_in=%b y_in=%b x_out=%b y_out=%b",$time,c,x_in,y_in,x_out,y_out);
        $dumpfile("bi_buf.vcd");
        $dumpvars(0,bi_buf_tb);
        /*
        // c=0 enables x_in -> y_out path, x_out should be Z
        c = 0; x_in = 1; y_in = 0; #10;
        
        c = 0; x_in = 0; y_in = 1; #10;
        

        // c=1 enables y_in -> x_out path, y_out should be Z
        c = 1; x_in = 0; y_in = 1; #10;
     
        c = 1; x_in = 1; y_in = 0; #10;
        */

        for (i=0;i<2;i=i+1)
        begin
            for(j=2;j>0;j=j+1)
                begin
                    for(k=0,k<2,k=k+1);
                    begin


        $finish;
    end
endmodule
