module four_1_mux(i,sel,y);
    input [3:0] i;
    input [1:0] sel;
    output y;
    wire [3:0] m;

    two_4_decoder uut_dec (.s(sel), .m(m));

    tristate_buf uut0 (.x(i[0]), .c(m[0]), .y(y));
    tristate_buf uut1 (.x(i[1]), .c(m[1]), .y(y));
    tristate_buf uut2 (.x(i[2]), .c(m[2]), .y(y));
    tristate_buf uut3 (.x(i[3]), .c(m[3]), .y(y));

endmodule