module tristate_buf(c,x,y);
     input x,c;
     output y;

    assign y = (c) ?  x : 1'bz;
endmodule