// mealy overlapping 1011 seq detector
module fsm_1011 (seq_in,rst,clk,d_out);
    input clk, seq_in, rst;
    output d_out;

    //state declaration
    reg [1:0] present_state, next_state;

    parameter IDLE = 2'b00;
    parameter   S1 = 2'b01;
    parameter   S2 = 2'b10;
    parameter   S3 = 2'b11;

    // block 1: present state seq logic

    always @ (posedge clk)
        begin
            if (rst)
                present_state <= IDLE;
            else 
                present_state <= next_state;
        end

    // block 2: next state comb logic

    always @ (present_state,seq_in)
        begin
            case (present_state)
                    IDLE : if (seq_in == 1)
                                next_state = S1;
                            else 
                                next_state = IDLE;
                    S1   : if (seq_in == 0)
                                next_state = S2;
                            else
                                next_state = S1;
                    S2   : if (seq_in == 1)
                                next_state = S3;
                            else
                                next_state = IDLE;
                    S3   : if (seq_in == 1)
                                next_state =  S1;
                            else 
                                next_state = S2;
                    default : next_state = IDLE;

            endcase
        end

    // output combinational logic

    assign d_out = (present_state == S3) && (seq_in == 1'd1);
    
    endmodule