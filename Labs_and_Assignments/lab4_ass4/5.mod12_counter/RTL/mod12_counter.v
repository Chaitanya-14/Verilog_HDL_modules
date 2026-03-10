module mod12_counter (clk,rst,load_en,count_en,data_in,data_out);
    input clk,rst,load_en,count_en;
    input [3:0] data_in;
    output reg [3:0] data_out;  

    always@(posedge clk)
        begin
            if (rst)
                data_out <= 4'b0000;
            else if (load_en)
                data_out <= data_in;
            else if (count_en)
                if (data_out == 4'b1011)
                    data_out <= 4'b0000;
                else 
                    data_out <= data_out + 1;
            else
                data_out <= data_out; 
        end


endmodule