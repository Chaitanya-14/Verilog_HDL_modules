module full_sub(a,b,c,d,bo);
    input a,b,c;
    output d,bo;
    wire w1,w2,w3;

    xor g1 (w1,a,b); xor g2 (d,w1,c);
    and g3 (w2,~(a),b); and g4 (w3,~w1,c);
    or g5 (bo,w3,w2);
endmodule

  
  