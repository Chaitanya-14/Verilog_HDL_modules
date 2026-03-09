module priority_8_3(i,m);
    input [7:0] i;
    output reg [2:0] m;
//procedural
    always @(*) begin
        m = 3'b000;
        if (i[7]) m=3'd7;
        else if (i[6]) m=3'd6;
        else if (i[5]) m=3'd5;
        else if (i[4]) m=3'd4;
        else if (i[3]) m=3'd3;
        else if (i[2]) m=3'd2;
        else if (i[1]) m=3'd1;
        else if (i[0]) m=3'd0;
    end
endmodule  
    

/*
dataflow
    assign m = i[7] ? 3'd7 :
               i[6] ? 3'b6 :
               i[5] ? 3'd5 :
               i[4] ? 3'd4 :
               i[3] ? 3'd3 :
               i[2] ? 3'd2 :
               i[1] ? 3'd1 :
               i[0] ? 3'd0 :
                      3'd0;*/
