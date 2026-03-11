module siso_4bit(clk,rst,serial_in,serial_out);
    input clk,rst,serial_in;
    output serial_out;

    reg [3:0] shift_reg;

    always@(posedge clk or posedge rst)
        begin
            if (rst)
            begin
                shift_reg <= 4'b0000;
            end
            else
                begin
                    shift_reg <= {serial_in,shift_reg[3:1]};
                end
        end
    assign serial_out = shift_reg [0];
endmodule
    