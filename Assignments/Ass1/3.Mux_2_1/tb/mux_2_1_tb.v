`timescale 1ns/1ps

module mux_2_1_tb;
    reg sel, i0, i1;
    wire y_out;

    mux_2_1 uut (.sel(sel), .i0(i0), .i1(i1), .y_out(y_out));

    task initialise;
        begin
            sel = 1'b0;
            i0  = 1'b0;
            i1  = 1'b0;
        end
    endtask

    task stimulus;
        input s;
        input a;
        input b;
        begin
            sel = s;
            i0  = a;
            i1  = b;
            #5;
        end
    endtask

    initial begin
        initialise;
        $dumpfile("mux_2_1.vcd");
        $dumpvars(0, mux_2_1_tb);
        $monitor("Time=%0t | sel=%b i0=%b i1=%b | y_out=%b", $time, sel, i0, i1, y_out);

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
