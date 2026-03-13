module fifo1(clk,rst,data_in,read_en,write_en,data_out,full,empty);
    input clk,rst,read_en,write_en;
    input [7:0] data_in;
    output full,empty;
    output reg [7:0] data_out;

    reg [7:0] mem [15:0];

    reg [3:0] wr_ptr;
    reg [3:0] rd_ptr;
    reg [4:0] count;

    // Write operation
    always@(posedge clk or negedge rst)
        begin
            if (!rst)
                begin
                    wr_ptr <= 4'b0000;
                end
            else if (write_en && !full)
                begin
                    mem[wr_ptr] <= data_in;
                    wr_ptr <= wr_ptr +1'b1;
                end
        end 

    //Read operation    
    always@(posedge clk or negedge rst) begin
        if (!rst) begin
            rd_ptr <= 4'b0000;
            data_out <= 8'h00;
        end
        else if (read_en && !empty)
            begin
                data_out <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1'b1;
            end
    end

    // count management (handles simultaneous read and write)
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            count <= 5'b00000;
        end
        else begin
            case ({write_en && !full , read_en && !empty})
                2'b10 : count <= count + 1'b1; //write
                2'b01 : count <= count - 1'b1; //read
                2'b11 : count <= count;     // simultaneous read and write
                default : count <= count;   // no operation
            endcase
        end
    end

    // status flags (comb)
    
    assign full = (count == 5'd16);
    assign empty = (count == 5'd0);
    
     

        
endmodule