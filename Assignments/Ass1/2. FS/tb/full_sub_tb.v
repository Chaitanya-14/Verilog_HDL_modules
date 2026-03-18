`timescale 1ns/1ps

module full_sub_tb;
    reg a, b, c;
    wire d_out, b_out;

    full_sub uut (.a(a), .b(b), .c(c), .d_out(d_out), .b_out(b_out));

    task initialise;
        begin
            a = 1'b0;
            b = 1'b0;
            c = 1'b0;
        end
    endtask

    task stimulus;
        input i;
        input j;
        input k;
        begin
            a = i;
            b = j;
            c = k;
            #5;
        end
    endtask

    initial begin
        initialise;
        $dumpfile("full_sub.vcd");
        $dumpvars(0, full_sub_tb);
        $monitor("Time=%0t | a=%b b=%b c=%b | diff=%b borrow=%b", $time, a, b, c, d_out, b_out);

        stimulus(1'b0, 1'b0, 1'b0);
        stimulus(1'b0, 1'b0, 1'b1);
        stimulus(1'b0, 1'b1, 1'b0);
        stimulus(1'b0, 1'b1, 1'b1);
        stimulus(1'b1, 1'b0, 1'b0);
        stimulus(1'b1, 1'b0, 1'b1);
        stimulus(1'b1, 1'b1, 1'b0);
        stimulus(1'b1, 1'b1, 1'b1);

        $finish;
    end

endmodule
