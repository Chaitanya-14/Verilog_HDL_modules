`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:47:55 03/04/2026 
// Design Name: 
// Module Name:    Full_adder 
// Project Name: 
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
module Full_adder(
    input a_in,
    input b_in,
    input c_in,
    output sum,
    output c_out
    );
	wire w1;
	wire w2;
	wire w3;
	
	Half_adder ha1 (.a_in(a_in), .b_in(b_in), .sum(w1), .carry(w3));
	
	Half_adder ha2 (.a_in(w1), .b_in(c_in), .sum(sum), .carry(w2));
	
	assign c_out = w2 | w3 ; 
		

endmodule
