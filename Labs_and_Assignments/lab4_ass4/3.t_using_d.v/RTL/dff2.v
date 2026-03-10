module dff2(clk,rst,d,q,qbar);
    input clk,d,rst;
    output reg q;
    output qbar;

    always @(posedge clk)
        if (rst)
            q <= 0;
        else 
            q <= d;
    
    assign qbar = ~q;
endmodule