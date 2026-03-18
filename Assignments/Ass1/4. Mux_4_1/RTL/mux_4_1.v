module mux_4_1 (i0,i1,i2,i3,sel,y_out);
    input i0,i1,i2,i3;
    input [1:0] sel;
    output wire y_out;
    wire w1,w2;

    mux_2_1 uut1 (.sel(sel[0]),.i0(i0),.i1(i1),.y_out(w1));
    mux_2_1 uut2 (.sel(sel[0]),.i0(i2),.i1(i3),.y_out(w2));
    mux_2_1 uut3 (.sel(sel[1]),.i0(w1),.i1(w2),.y_out(y_out));

endmodule