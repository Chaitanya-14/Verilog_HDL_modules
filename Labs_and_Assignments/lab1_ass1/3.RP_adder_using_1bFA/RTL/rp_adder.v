module rp_adder(a,b,cin,sum,cout);
    input [3:0] a;
    input [3:0] b;
    input cin;
    output [3:0] sum;
    output [3:0] cout;


    one_b_fa uut1 (.a(a[0]),.b(b[0]),.c(cin),.sum(sum[0]),.carry(cout[0]));
    one_b_fa uut2 (.a(a[1]),.b(b[1]),.c(cout[0]),.sum(sum[1]),.carry(cout[1]));
    one_b_fa uut3 (.a(a[2]),.b(b[2]),.c(cout[1]),.sum(sum[2]),.carry(cout[2]));
    one_b_fa uut4 (.a(a[3]),.b(b[3]),.c(cout[2]),.sum(sum[3]),.carry(cout[3]));

endmodule
