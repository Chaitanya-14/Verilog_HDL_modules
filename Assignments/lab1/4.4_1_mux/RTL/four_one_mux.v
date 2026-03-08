module four_one_mux(i0,i1,i2,i3,y,sel);
    input i0,i1,i2,i3;
    input [1:0] sel;
    output y;
    wire w1,w2;

    two_one_mux uut1 (.i0(i0),.i1(i1),.y(w1),.sel(sel[0]));
    two_one_mux uut2 (.i0(i2),.i1(i3),.y(w2),.sel(sel[0]));
    two_one_mux uut3 (.i0(w1),.i1(w2),.y(y),.sel(sel[1]));

endmodule
