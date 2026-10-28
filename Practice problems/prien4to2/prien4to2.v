module prien4to2 (data_in,y_out);
    input [3:0] data_in;
    output reg [1:0] y_out;

    always@(*)
    begin
            if (data_in[3])
                y_out = 2'd3;
            else if (data_in[2])
                y_out = 2'd2;
            else if (data_in[1])
                y_out = 2'd1;
            else if (data_in[0])
                y_out = 2'd0;
            else 
                y_out = 2'd0;   
    end
endmodule