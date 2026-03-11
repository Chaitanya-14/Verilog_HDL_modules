module sync_ram_16_8 (clk,rst,wr_en,wr_addr,rd_en,rd_addr,data_in,data_out);

    input clk, rst , wr_en, rd_en;
    input [3:0] wr_addr, rd_addr;
    input [7:0] data_in;
    output reg [7:0] data_out;
    integer i;

    reg [7:0] mem [15:0];
 
    always@(posedge clk)
        begin
            if (rst) begin
                for (i=0;i<16;i=i+1)
                begin
                    mem[i] = 8'b00000000;
                end
            end
            else if (wr_en)
                begin
                    mem[wr_addr] = data_in;
                end
            else if (rd_en)
                begin
                    data_out = mem[rd_addr];
                end
        end

endmodule