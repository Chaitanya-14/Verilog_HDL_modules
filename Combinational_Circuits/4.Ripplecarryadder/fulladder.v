module fulladder(a,b,c,s,cout);
    input a,b,c;
    output s,cout;
    wire t1,t2,t3;
    xor g1(t1,a,b), g2(s,t1,c);
    and g3(t2,t1,c), g4(t3,a,b);
    or g5(cout,t2,t3);
endmodule 

