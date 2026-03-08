`timescale 1ns/1ps
module four_1_tb_selfchecking ;
    reg [3:0] i;
    reg [1:0] sel;
    wire y;

    reg expected_y;
    integer vec, j;
    integer pass_count, fail_count;

    four_1_mux uut1 (.i(i),.sel(sel),.y(y));

    task apply_stimulus_and_check;
        input [3:0] ta;
        input [1:0] ts;
        begin
            i = ta;
            sel = ts;

            case (ts)
                2'b00: expected_y = ta[0];
                2'b01: expected_y = ta[1];
                2'b10: expected_y = ta[2];
                2'b11: expected_y = ta[3];
                default: expected_y = 1'b0;
            endcase

            #10;

            if (y === expected_y) begin
                pass_count=pass_count+1;
            end
            else
            begin
                fail_count = fail_count + 1;
                $display("FAIL Time= %0t i=%b sel=%b y=%b expected=%b",$time,i,sel,y,expected_y);
            end
        end
    endtask

    initial
    begin
        $dumpfile("four_1_tb_selfchecking.vcd");
        $dumpvars(0,four_1_tb_selfchecking);

        pass_count = 0;
        fail_count = 0;

        for (vec=0; vec<16; vec=vec+1)
        begin
            for (j=0; j<4; j=j+1)
            begin
                apply_stimulus_and_check(vec[3:0], j[1:0]);
            end
        end

        $display("SUMMARY: PASS=%0d FAIL=%0d",pass_count,fail_count);
        if (fail_count==0)
            $display ("All tests PASSED!!!");
        else
            $display("Some tests are FAILED");



        $finish;

    end
endmodule

