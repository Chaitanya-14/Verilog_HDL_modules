`timescale 1ns/1ps

module mux_4_1_tb;
    reg [1:0] sel;
    reg i0, i1, i2, i3;
    wire y_out;

    mux_4_1 uut (.i0(i0), .i1(i1), .i2(i2), .i3(i3), .sel(sel), .y_out(y_out));

    task initialise;
        begin
            sel = 2'b00;
            i0  = 1'b0;
            i1  = 1'b0;
            i2  = 1'b0;
            i3  = 1'b0;
        end
    endtask

    task stimulus;
        input [1:0] s;
        input a;
        input b;
        input c;
        input d;
        begin
            sel = s;
            i0  = a;
            i1  = b;
            i2  = c;
            i3  = d;
            #5;
        end
    endtask

    initial begin
        initialise;
        $dumpfile("mux_4_1.vcd");
        $dumpvars(0, mux_4_1_tb);
        $monitor("Time=%0t | sel=%b i0=%b i1=%b i2=%b i3=%b | y_out=%b", $time, sel, i0, i1, i2, i3, y_out);

        stimulus(2'b00, 1'b0, 1'b0, 1'b0, 1'b0);
        stimulus(2'b00, 1'b1, 1'b0, 1'b0, 1'b0);
        stimulus(2'b01, 1'b0, 1'b1, 1'b0, 1'b0);
        stimulus(2'b10, 1'b0, 1'b0, 1'b1, 1'b0);
        stimulus(2'b11, 1'b0, 1'b0, 1'b0, 1'b1);

        stimulus(2'b00, 1'b1, 1'b1, 1'b0, 1'b0);
        stimulus(2'b01, 1'b1, 1'b1, 1'b0, 1'b0);
        stimulus(2'b10, 1'b0, 1'b1, 1'b1, 1'b0);
        stimulus(2'b11, 1'b0, 1'b0, 1'b1, 1'b1);

        stimulus(2'b00, 1'b1, 1'b0, 1'b1, 1'b0);
        stimulus(2'b01, 1'b1, 1'b0, 1'b1, 1'b0);
        stimulus(2'b10, 1'b1, 1'b0, 1'b1, 1'b0);
        stimulus(2'b11, 1'b1, 1'b0, 1'b1, 1'b0);

        $finish;
    end

endmodule
