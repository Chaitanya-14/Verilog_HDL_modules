module two_4_decoder (s,m);
    input [1:0] s;
    output [3:0] m;

    assign m = (s == 2'b00) ? 4'b0001 :
               (s == 2'b01) ? 4'b0010 :
               (s == 2'b10) ? 4'b0100 :
                               4'b1000;

endmodule