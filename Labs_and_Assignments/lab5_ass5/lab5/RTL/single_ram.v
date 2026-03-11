module single_ram(wr_en,rd_en,data,addr);
    input wr_en,rd_en;
    input [3:0] addr;
    inout [7:0] data;

    reg [7:0] mem [15:0];

    assign data = (rd_en && !wr_en) ? mem[addr] : 8'bzz;

    always@(*)
        begin
            if (wr_en && !rd_en) begin
                mem[addr] = data;
            end
        end

endmodule

