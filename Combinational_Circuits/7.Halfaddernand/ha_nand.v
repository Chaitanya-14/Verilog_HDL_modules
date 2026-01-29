module ha_nand(a,b,s,cout);
    input a,b;
    output s,cout;
    wire w1,w3,w4,w5;

    nand g1 (w1,a,b);
    nand g2 (w3,a,w1);
    nand g3 (w4,w1,b);
    nand g4 (s,w3,w4);
    nand g5 (cout,w1,w1);

endmodule

