module alu (
    input [7:0] a_in, b_in,
    input [3:0] command_in,
    input oe,
    output [15:0] d_out
);

reg [15:0] out;

parameter ADD = 4'b0000,  // Add two 8-bit numbers a and b
          SUB = 4'b0001,  // Subtract b from a
          MUL = 4'b0010,  // Multiply a and b
          DIV = 4'b0011,  // Divide b by a
          INC = 4'b0100,  // Increment a by 1
          DEC = 4'b0101,  // Decrement a by 1
          SHL = 4'b0110,  // Shift a left by 1 bit
          SHR = 4'b0111,  // Shift a right by 1 bit
          AND = 4'b1000,  // Logical AND of a and b
          OR = 4'b1001,   // Logical OR of a and b
          INV = 4'b1010,  // Logical inverse of a
          NAND = 4'b1011, // NAND of a and b
          NOR = 4'b1100,  // NOR of a and b
          XOR = 4'b1101,  // XOR of a and b
          XNOR = 4'b1110, // XNOR of a and b
          BUF = 4'b1111;  // Output of a

always @(a_in, b_in, command_in)
begin
  case(command_in)
    ADD:   out = a_in + b_in;
    SUB:   out = b_in - a_in;
    MUL:   out = a_in * b_in;
    DIV:   out = b_in / a_in;
    SHL:   out = a_in << 1'b1;
    SHR:   out = a_in >> 1'b1;
    AND:   out = a_in & b_in;
    OR:    out = a_in | b_in;
    INV:   out = ~a_in;
    NAND:  out = ~(a_in & b_in);
    NOR:   out = ~(a_in | b_in);
    XOR:   out = a_in ^ b_in;
    XNOR:  out = ~(a_in ^ b_in);
    BUF:   out = a_in;
    default: out = 16'b0;
  endcase
end 

assign d_out = (oe) ? out : 16'bz;

endmodule 