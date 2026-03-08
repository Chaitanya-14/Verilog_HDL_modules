module bi_buf (x_in,y_out,y_in,x_out,c);
    input x_in,y_in;
    output x_out,y_out;
    input c;

    tri_buf_high uut1 (.x(y_in),.y(x_out),.c(c));
    tri_buf_low uut2 (.x(x_in),.y(y_out),.c(c));

endmodule