module dec_2_4(i,m);
    input [1:0] i;
    output [3:0] m;

    assign m[0] = (~i[0] && ~i[1]) ? 1'b1 : 1'b0;
    assign m[1] = (~i[0] && i[1]) ? 1'b1 : 1'b0;
    assign m[2] = (i[0] && ~i[1]) ? 1'b1 : 1'b0;
    assign m[3] = (i[0] && i[1]) ? 1'b1 : 1'b0;
endmodule