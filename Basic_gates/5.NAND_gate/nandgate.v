module nandgate (a,b,f);
    input a,b;
    output f;
    assign f = ~(a&b);
endmodule