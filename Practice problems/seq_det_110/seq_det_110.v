module seq_det (clk,rst,seq_in,det_out);
    input clk,rst,seq_in;
    output det_out;
    parameter S0 = 4'b0001,
              S1   = 4'b0010,
              S2   = 4'b0100,
              S3   = 4'b1000;

    reg [3:0] present, next;

    always@(posedge clk) //present state logic
    begin
        if(rst)
            present <= S0;
        else
            present <= next;
    end

    always@(*)
    begin
        next = S0;
        case (present)
            S0 : begin if(seq_in) next=S1; end
            S1 : begin if(seq_in) next=S2; end
            S2 : begin if(seq_in) 
                        next=S2;
                        else
                        next=S3;
                         end
            S3 : begin if(seq_in) next=S1;
                        else
                            next=S0;
                    end
            default : next = S0;
        endcase
    end

    assign det_out = (present == S2) ? 1 : 0;  //out comb logic
endmodule
