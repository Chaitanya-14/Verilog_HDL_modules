module sr_latch(set,reset,q_out,qbar);
    input set, reset;
    output q_out,qbar;
    //wire w1,w2;

    srnand uut1 (.a(set), .b(qbar), .y(q_out));
    srnand uut2 (.a(q_out), .b(reset), .y(qbar));

endmodule