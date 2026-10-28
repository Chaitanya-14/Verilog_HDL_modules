module dff_sync_rst (d_in,clk,q,q_bar,rst);
    input d_in, clk,rst;
    output reg q;
    output q_bar;

    always @(posedge clk)
    begin
        if(rst)
            q <= 1'b0;
        else
            q <= d_in;       
    end
    assign q_bar = ~q;
endmodule
