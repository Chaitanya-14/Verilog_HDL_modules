module rpc_adder(a,b,cin,s,cout);
    input [3:0] a,b; input cin; 
    output [3:0] s;
    output cout;
    wire c1,c2,c3;

    fulladder fa1 (.a(a[0]),.b(b[0]),.c(cin),.s(s[0]),.cout(c1));
    fulladder fa2 (.a(a[1]),.b(b[1]),.c(c1),.s(s[1]),.cout(c2));
    fulladder fa3 (.a(a[2]),.b(b[2]),.c(c2),.s(s[2]),.cout(c3));
    fulladder fa4 (.a(a[3]),.b(b[3]),.c(c3),.s(s[3]),.cout(cout));


endmodule
