module router_fifo #(parameter WIDTH = 8, DEPTH = 16)
                    (input clock,
                    input resetn,
                    input write_enb,
                    input soft_reset,
                    input read_enb,
                    input [(WIDTH-1):0] data_in,
                    input lfd_state,
                    output empty,
                    output full,
                    output reg [(DEPTH-1):0]data_out);

    // internal variables
    reg [4:0] wr_ptr;
    reg [4:0] rd_ptr;
    reg [6:0] count;
    reg [8:0] mem [(DEPTH-1):0]; // depth 16X9 width

    integer i;

    //FIFO full and empty logic
    assign empty = (wr_ptr == rd_ptr) ? 1'b1 : 1'b0;
    assign full = (wr_ptr == {~rd_ptr[4],rd_ptr[3:0]}) ? 1'b1 : 1'b0;
    
    // write operation
    /*
    condition:
    - data_in is sampled at the rising edge of the clock when write_enb is high
    - write operaton takes place only when fifo is not full in order to avoid over run condition.
    */
    always @ (posedge clock)
        begin
            if (!resetn)
                begin
                    wr_ptr <= 4'b0000;
                    for (i=0;i<DEPTH;i=i+1)
                        begin
                            mem[i] <= 0;
                        end
                end
            else if (soft_reset)
                begin
                    wr_ptr <= 0;
                    for (i=0 ; i<16 ; i=i+1)
                        begin
                            mem[i] <= 0;
                        end
                end

            else 
                begin
                    if (write_enb && !full)
                        begin
                            mem[wr_ptr[3:0]] <= {lfd_state,data_in};
                            wr_ptr <= wr_ptr + 1'b1;
                        end
                end
        end

    // FIFO read operation
    always @ (posedge clock)
        begin
            if (!resetn)
                begin
                    rd_ptr <= 0;
                    data_out <= 0;
                end            
             else if (read_enb && !empty)
                begin
                    data_out <= mem[rd_ptr];
                    rd_ptr <= rd_ptr - 1'b1;
                end
            
        end

    // count operation
    always @ (posedge clock)
        begin
            if (resetn)
                begin
                    count <= 5'b00000;
                end
            else 
                begin
                    case ({write_enb && !full,read_enb && !empty})
                        2'b10 : count <= count + 1'b1;
                        2'b01 : count <= count - 1'b1;
                        2'b11 : count <= count;
                        default : count <= count;
                    endcase                      
                end
        end



    







endmodule