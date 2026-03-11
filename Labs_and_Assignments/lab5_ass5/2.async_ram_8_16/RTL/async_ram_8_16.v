module async_ram_8_16 (clk,rst,rd_en,wr_en,rd_addr,wr_addr,data_in,data_out);
    input clk,rst,rd_en,wr_en;
    input [2:0] rd_addr ,wr_addr;
    input [15:0] data_in;
    output [15:0] data_out;
    integer i;

    reg [15:0] mem [7:0];

    always@(posedge clk)
        begin
            if (rst)begin
                for (i=0;i<7;i=i+1)
                begin
                    mem[i] = 16'h0000;
                end
            end
            else if (wr_en && !rd_en)
                begin
                    mem[wr_addr] = data_in;
                end
        end

    // Asynchronous read
    assign data_out = (rd_en && !wr_en) ? mem[rd_addr] : 16'hzzzz;
endmodule 
            