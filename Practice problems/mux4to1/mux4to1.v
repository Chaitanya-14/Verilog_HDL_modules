module mux4to1 (data_in,sel_in,out);
    input [3:0] data_in;
    input [1:0] sel_in;
    output reg out;
    
    always @(*)
    begin
        case (sel_in)
        begin
            2'b00 : out = data_in[0];
            2'b01 : out = data_in[1];
            2'b10 : out = data_in[2];
            2'b11 : out = data_in[3];
            default : out = 0; 
        end
        endcase

    end
endmodule