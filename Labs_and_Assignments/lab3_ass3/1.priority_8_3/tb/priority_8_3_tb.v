`timescale 1ns/1ps

module priority_8_3_tb;
    reg [7:0] in;
    wire [2:0] out;

    priority_8_3 uut (.i(in), .m(out));

    task initialise;
    begin
        in = 0;
    end
    endtask

    task stimulus;
        input [7:0] tin;
        begin
            #10;
            in = tin;
        end
    endtask

    initial
    begin
    $dumpfile("priority_8_3.vcd");
    $dumpvars(0,priority_8_3_tb);
    initialise;
    stimulus(8'b10000000);
    stimulus(8'b01000000);
    stimulus(8'b00100000);
    stimulus(8'b00010000);
    stimulus(8'b00001000);
    stimulus(8'b00000100);
    stimulus(8'b00000010);
    stimulus(8'b00000001);
    stimulus(8'b10101001);
    stimulus(8'b00000000);
    end

    initial
    begin
        $monitor("Time=%0t in=%b out=%b", $time, in, out);
    end


    initial
    #100 $finish;

endmodule 
