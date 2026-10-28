module alu(enable,command,op_1,op_2,out);
    input enable;
    input [3:0] command;
    input [7:0] op_1, op_2;
    output [15:0] y_out;
    
    reg [15:0] tmp;

    parameter ADD = 4'b0000,
              INC = 4'b0001,
              SUB = 4'b0010,
              DEC = 4'b0011,
              MUL = 4'b0100,
              DIV = 4'b0101,
              SHL = 4'b0110,
              SHR = 4'b0111,
              INV = 4'b1000,
              AND = 4'b1001,
              OR = 4'b1010,
              NAND = 4'b1011,
              NOR = 4'b1100,
              XOR = 4'b1101,
              XNOR = 4'b1110,
              BUF = 4'b1111;


    always@(command,op_1,op_2)
    begin
        case (command)
            4'b0000 : tmp = op_1 + op_2;
            4'b0001 : tmp = op_1 + 1;
            4'b0010 : tmp = op_1 - op_2;
            4'b0011 : tmp = op_1 -1;
            4'b0100 : tmp = op_1 * op_2;
            4'b0101 : tmp = op_1 /2;
            4'b0110 : tmp = op_1 << 1'b1;
            4'b0111 : tmp = op_1 >> 1'b1;
            4'b1000 : tmp = ~op_1; 
            4'b1001 : tmp = op_1 & op_2;
            4'b1010 : tmp = op_1 | op_2;
            4'b1011 : tmp = ~(op_1 & op_2);
            4'b1100 : tmp = ~(op_1 | op_2);
            4'b1101 : tmp = op_1 ^ op_2;
            4'b1110 : tmp = ~(op_1 ^ op_2);
            4'b1111 : tmp = op_1;
        endcase

    end

    assign out = (enable) ? tmp : 4'bzzzz;

endmodule



