module two_one_mux (i0,i1,y,sel);
    input i0,i1;
    input sel;
    output y;

    assign y = (sel) ? i1 : i0;
endmodule

/*

always @ (*)
    begin
        case (sel)
            1'b0 : y = i0;
            1'b1 : y = i1;
            default : y = 1'b0;
        endcase
    end

*/
