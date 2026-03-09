`timescale 1ns/1ps
module three_8_dec_tb;

    reg [2:0] in;
    wire [7:0] out;
    integer i;

    three_8_dec uut (.i(in),.m(out));
    
    task apply_stimulus;
        input [2:0] tin;
        begin
            #10;
            in = tin;
        end
    endtask

    task initialise;
        begin
            in = 3'b000;
        end
    endtask

    initial
    begin
        $dumpfile("Decoder_3_8.vcd");
        $dumpvars(0,three_8_dec_tb);
        initialise;
        for (i=0;i<8;i=i+1)
        begin
            apply_stimulus (i[2:0]);
        end

    end

    initial
    begin
    $monitor("Time=%0t input=%b output=%b",$time,in,out);
    end

    initial
    #100 $finish;
endmodule

