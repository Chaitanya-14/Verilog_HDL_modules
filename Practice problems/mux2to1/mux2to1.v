module mux2to1 (i0,i1,sel,out);
    input i0,i1,sel;
    output reg out;

    always @ (*)
        begin
            if (~sel)
                out = i0;
            else
                out = i1;
        end
endmodule