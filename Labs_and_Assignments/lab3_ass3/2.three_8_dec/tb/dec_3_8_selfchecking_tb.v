`timescale 1ns/1ps

module dec_3_8_selfchecking_tb;
    reg [2:0] in;
    wire [7:0] out;
    reg [7:0] expected_out;
    integer i;
    integer pass_count, fail_count;

    three_8_dec uut (.i(in), .m(out));

    task initialise;
        begin
            in = 3'b000;
            pass_count = 0;
            fail_count = 0;
        end
    endtask

    task apply_stimulus_and_check;
        input [2:0] tin;
        begin
            in = tin;
            expected_out = 8'b0000_0001 << tin;
            #10;

            if (out === expected_out) begin
                pass_count = pass_count + 1;
            end else begin
                fail_count = fail_count + 1;
                $display("FAIL Time=%0t in=%b out=%b expected=%b", $time, in, out, expected_out);
            end
        end
    endtask

    initial begin
        $dumpfile("Decoder_3_8_selfcheck.vcd");
        $dumpvars(0, dec_3_8_selfchecking_tb);

        initialise;

        for (i = 0; i < 8; i = i + 1) begin
            apply_stimulus_and_check(i[2:0]);
        end

        $display("SUMMARY: PASS=%0d FAIL=%0d", pass_count, fail_count);
        if (fail_count == 0)
            $display("ALL TESTS PASSED");
        else
            $display("SOME TESTS FAILED");

        $finish;
    end
endmodule
