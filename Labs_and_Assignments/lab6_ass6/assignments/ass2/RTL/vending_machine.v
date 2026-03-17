module vending_machine(clk,rst,co_in0,co_in1,x_out,y_out);
    input clk,rst,co_in0,co_in1;
    output reg x_out,y_out;

    reg [1:0] present_state, next_state;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;

    // sequential for present state determination
    always @ (posedge clk)
        begin
            if (rst)
                present_state <= S0;
            else 
                present_state <= next_state;        
        end

    // Next state combinational logic
    always @ (present_state,co_in0,co_in1)
        begin
            case(present_state)
                S0 : if (co_in0 == 1'b0) begin
                        next_state = S0;
                        x_out = 0 ; y_out = 0; 
                        end
                    else if (co_in0 == 1'b1 && co_in1 == 1'b0) begin
                        next_state = S1;
                        x_out = 0 ; y_out = 0; 
                    end
                    else if (co_in0 == 1'b1 && co_in1 == 1'b1) begin
                        next_state = S2;
                        x_out = 0 ; y_out = 0;
                    end
                S1 : if (co_in0 == 1'b0) begin
                        next_state = S1;
                        x_out = 0 ; y_out = 0; 
                        end
                    else if (co_in0 == 1'b1 && co_in1 == 1'b0) begin
                        next_state = S2;
                        x_out = 0 ; y_out = 0; 
                    end
                    else if (co_in0 == 1'b1 && co_in1 == 1'b1) begin
                        next_state = S0;
                        x_out = 1 ; y_out = 0;
                    end
                S2 : if (co_in0 == 1'b0) begin
                        next_state = S2;
                        x_out = 0 ; y_out = 0; 
                        end
                    else if (co_in0 == 1'b1 && co_in1 == 1'b0) begin
                        next_state = S0;
                        x_out = 1 ; y_out = 0; 
                    end
                    else if (co_in0 == 1'b1 && co_in1 == 1'b1) begin
                        next_state = S0;
                        x_out = 1 ; y_out = 1;
                    end
                default : begin
                        next_state = S0;
                        x_out = 1'b0;
                        y_out = 1'b0;
                end
            endcase
        end

endmodule