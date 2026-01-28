module fa_ha(a,b,cin,s,cout);
    input a,b,cin;
    output s,cout;
    wire s1,w1,w2;

    // First Half adder
    // . port name from the module (signal name from the current module)
    half_adder HA1 (.a(a),.b(b),.s(s1),.c(w1));

    // Second half adder
    half_adder HA2 (.a(s1),.b(cin),.s(s),.c(w2));

    assign cout = w1 | w2;

endmodule
