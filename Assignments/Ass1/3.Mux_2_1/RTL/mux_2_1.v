// gate level abstraction
module mux_2_1 (sel,i0,i1,y_out);
    input sel , i0 , i1;
    output y_out;
    wire w1 ,w2, sel_n;

    not (sel_n,sel);
    and (w1,sel_n,i0);
    and (w2,sel,i1);
    or (y_out,w1,w2);

endmodule