`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:59:36 03/04/2026
// Design Name:   Full_adder
// Module Name:   /home/chaitanya/Documents/Abstraction_Levels/Full_adder_tb.v
// Project Name:  Abstraction_Levels
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Full_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Full_adder_tb;

	// Inputs
	reg a_in;
	reg b_in;
	reg c_in;

	// Outputs
	wire sum;
	wire c_out;

	// Instantiate the Unit Under Test (UUT)
	Full_adder uut (
		.a_in(a_in), 
		.b_in(b_in), 
		.c_in(c_in), 
		.sum(sum), 
		.c_out(c_out)
	);

	initial begin
		// Initialize Inputs
		a_in = 0;
		b_in = 0;
		c_in = 0;
		
		#10
		a_in = 0;
		b_in = 0;
		c_in = 1;
		#10
		a_in = 0;
		b_in = 1;
		c_in = 0;
		#10
		a_in = 0;
		b_in = 1;
		c_in = 1;
		#10
		a_in = 1;
		b_in = 0;
		c_in = 0;
		#10
		a_in = 1;
		b_in = 0;
		c_in = 1;
		#10
		a_in = 1;
		b_in = 1;
		c_in = 0;
		#10
		a_in = 1;
		b_in = 1;
		c_in = 1;

		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$finish

	end
      
endmodule

