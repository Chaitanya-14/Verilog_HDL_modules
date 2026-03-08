module tri_buf_high (x,y,c);
    input x;
    output y;
    input c;

    assign y = (c) ?  x : 1'bz;
endmodule 