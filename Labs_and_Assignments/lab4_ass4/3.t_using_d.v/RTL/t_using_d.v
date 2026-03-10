module t_using_d(t, clk, rst, q, qbar);
    input t, clk, rst;
    output q,qbar;
    wire w1;

    assign w1 = t ^ q;
    dff2 uut (.clk(clk), .rst(rst), .d(w1), .q(q), .qbar(qbar));

endmodule