module full_sub (a , b , c , d_out , b_out);
    input a , b , c;
    output d_out , b_out ;
    wire w1,w2,w3;

    half_sub uut  (.a(a),.b(b),.diff(w1),.borr(w2));
    half_sub uut1 (.a(w1),.b(c),.diff(d_out),.borr(w3) );

    assign b_out = w2 | w3 ;
endmodule 
