`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Self	
// Engineer: Chaitanya Roy
// 
// Create Date:    20:11:08 03/04/2026 
// Design Name: 
// Module Name:    Half_adder 
// Project Name: Abstraction levels
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Half_adder(
    input a_in,
    input b_in,
    output sum,
    output carry
    );
	assign sum = a_in ^ b_in;
	assign carry = a_in & b_in;

endmodule
