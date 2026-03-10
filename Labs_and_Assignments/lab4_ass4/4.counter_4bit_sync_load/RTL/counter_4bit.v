module counter_4bit(clk,rst,data_in,data_out,load_en,count_en);
    input clk,rst,load_en,count_en;
    input [3:0] data_in;
    output reg [3:0] data_out;
    
    always@(posedge clk)
    begin
        if (rst)begin
            data_out <= 4'b0000;
        end
        else if (load_en) begin
            data_out <= data_in;
        end
        else if (count_en) begin
            data_out <= data_out + 1;
        end
        else 
            data_out <= data_out;
    end

endmodule

