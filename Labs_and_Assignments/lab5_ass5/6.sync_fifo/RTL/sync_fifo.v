module sync_fifo(clk,rst,write_en,read_en,data_in,data_out,full,empty,almost_full,almost_empty);
    input clk,rst; // active high and sync reset
    input write_en,read_en; // active high 
    input [15:0] data_in;
    output reg [15:0] data_out;
    output full,empty,almost_full,almost_empty;

    reg [15:0] mem [31:0];
    

    reg [4:0] wr_ptr; // to point towards 32 wr address locations
    reg [4:0] rd_ptr; // to point to 32 rd address locations
    reg [5:0] count; // for counting


    // for write operation
    always@ (posedge clk)
        begin
            if (rst) begin
                    wr_ptr <= 5'b00000;
                end
            else if (write_en && !full)
                begin
                    mem[wr_ptr] <= data_in;
                    wr_ptr <= wr_ptr + 1'b1;
                end              
        end

    // for read operation
    always @ (posedge clk)
        begin
            if (rst)
                begin
                    rd_ptr <= 5'b00000;
                    data_out <= 16'h0000;  // reset data_out here
                end
            else if (read_en && !empty)
                begin
                    data_out <= mem[rd_ptr];
                    rd_ptr <= rd_ptr + 1'b1;
                end
        end

    // count operation
    always @ (posedge clk) begin
        if (rst) 
        begin
            count <= 6'b000000;
        end
        else
        begin
            case ({write_en && !full , read_en && !empty})
                2'b10 : count <= count + 1'b1;
                2'b01 : count <= count - 1'b1;
                2'b11 : count <= count;
                default : count <= count;
            endcase
        end
    end
    //status flags
    assign full = (count == 6'd32);
    assign empty = (count == 6'd0);
    assign almost_full = (count >= 6'd30);
    assign almost_empty = (count <= 6'd2);
endmodule