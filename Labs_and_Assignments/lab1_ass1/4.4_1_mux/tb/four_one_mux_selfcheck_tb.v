`timescale 1ns/1ps

module four_one_mux_selfcheck_tb;
    reg i0, i1, i2, i3;
    reg [1:0] sel;
    wire y;

    reg expected_y;
    integer i, j;
    integer pass_count, fail_count;

    four_one_mux dut (
        .i0(i0),
        .i1(i1),
        .i2(i2),
        .i3(i3),
        .sel(sel),
        .y(y)
    );

    task apply_and_check;
        input [3:0] data;
        input [1:0] s;
        begin
            {i0, i1, i2, i3} = data;
            sel = s;
            #10;

            case (sel)
                2'b00: expected_y = i0;
                2'b01: expected_y = i1;
                2'b10: expected_y = i2;
                2'b11: expected_y = i3;
                default: expected_y = 1'b0;
            endcase

            if (y === expected_y) begin
                pass_count = pass_count + 1;
            end else begin
                fail_count = fail_count + 1;
                $display("FAIL t=%0t data=%b sel=%b y=%b expected=%b", $time, {i0, i1, i2, i3}, sel, y, expected_y);
            end
        end
    endtask

    initial begin
        $dumpfile("four_one_mux_selfcheck.vcd");
        $dumpvars(0, four_one_mux_selfcheck_tb);

        pass_count = 0;
        fail_count = 0;

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                apply_and_check(i[3:0], j[1:0]);
            end
        end

        $display("SUMMARY: PASS=%0d FAIL=%0d", pass_count, fail_count);
        if (fail_count == 0)
            $display("ALL TESTS PASSED");
        else
            $display("SOME TESTS FAILED");

        $finish;
    end
endmodule
