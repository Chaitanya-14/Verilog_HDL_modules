`timescale 1ns/1ps
module four_one_mux_tb ;
    reg i0,i1,i2,i3;
    reg [1:0]sel;
    wire y;
    integer i,j;

    four_one_mux uut1 (.i0(i0),.i1(i1),.i2(i2),.i3(i3),.sel(sel),.y(y));

    task apply_stimulus;
        input [3:0] ta;
        input [1:0] tsel;
        begin
            {i0,i1,i2,i3} = ta;
            sel = tsel;
            #10;
            $display("Time=%0t i0=%b i1=%b i2=%b i3=%b y=%b sel=%b ",$time,i0,i1,i2,i3,y,sel);
        end
    endtask

    initial 
    begin
        $dumpfile("four_one_mux.vcd");
        $dumpvars(0,four_one_mux_tb);

        for (i=0; i<16; i=i+1)
        begin
            for (j=0;j<4;j=j+1)
            begin
                apply_stimulus(i[3:0],j[1:0]);
            end
        end
        $finish;
    end
endmodule
