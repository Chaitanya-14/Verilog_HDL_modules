module tri_buf_low (x,y,c);
    input x;
    output y;
    input c;

    assign y = (c) ?  1'bz : x ;
endmodule 