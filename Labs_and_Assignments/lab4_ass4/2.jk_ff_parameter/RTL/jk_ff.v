module jk_ff(clock, j, k, q, qb);
    input clock, j,k;
    output reg q;
    output qb;

    localparam HOLD = 2'b00;
    localparam RESET = 2'b01;
    localparam SET = 2'b10;
    localparam TOGGLE = 2'b11;

    always @(posedge clock)
    begin
        case ({j,k})
            HOLD  : q <= q;
            RESET : q <= 1'b0;
            SET   : q <= 1'b1;
            TOGGLE: q <= ~q;
        endcase
    end

    assign qb = ~q;
endmodule
