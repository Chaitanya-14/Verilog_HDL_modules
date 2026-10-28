module full_adder (a,b,c,sum_out,c_out);
    input a,b,c;
    output sum_out,c_out;

    wire w1,w2,w3;

    half_adder HA1 (.a_in(a),.b_in(b),.sum_out(w1),.carry_out(w2));
    half_adder HA2 (.a_in(w1),.b_in(c),.sum_out(sum_out),.carry_out(w3));
    or OR1(c_out,w2,w3);
    
endmodule