`timescale 1ns/1ps
module four_1_mux_tb ;
    reg [3:0] i;
    reg [1:0] sel;
    wire y;
    integer vec, j;

    four_1_mux uut1 (.i(i),.sel(sel),.y(y));

    task apply_stimulus;
        input [3:0] ta;
        input [1:0] ts;
        begin
            i = ta;
            sel = ts;
            #10;
            $display("Time= %0t i=%b sel=%b y=%b",$time,i,sel,y);
        end
    endtask

    initial
    begin
        $dumpfile("four_1_mux.vcd");
        $dumpvars(0,four_1_mux_tb);

        for (vec=0; vec<16; vec=vec+1)
        begin
            for (j=0; j<4; j=j+1)
            begin
                apply_stimulus(vec[3:0], j[1:0]);
            end
        end
        $finish;

    end
endmodule

