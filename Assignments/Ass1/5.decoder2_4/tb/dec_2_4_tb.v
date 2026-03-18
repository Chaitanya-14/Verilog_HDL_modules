`timescale 1ns/1ps

module dec_2_4_tb;
    reg [1:0] i;
    wire [3:0] m;

    dec_2_4 uut (.i(i), .m(m));

    task initialise;
        begin
            i = 2'b00;
        end
    endtask

    task stimulus;
        input [1:0] in;
        begin
            i = in;
            #5;
        end
    endtask

    initial begin
        initialise;
        $dumpfile("dec_2_4.vcd");
        $dumpvars(0, dec_2_4_tb);
        $monitor("Time=%0t | i=%b | m=%b", $time, i, m);

        stimulus(2'b00);
        stimulus(2'b01);
        stimulus(2'b10);
        stimulus(2'b11);

        $finish;
    end

endmodule
