module three_8_dec(i, m);
    input [2:0] i;
    output [7:0] m;

    assign m = 8'b0000_0001 << i;

endmodule

