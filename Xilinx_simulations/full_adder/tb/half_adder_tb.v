`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:17:23 03/04/2026
// Design Name:   Half_adder
// Module Name:   /home/chaitanya/Documents/Abstraction_Levels/half_adder_tb.v
// Project Name:  Abstraction_Levels
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Half_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module half_adder_tb;

	// Inputs
	reg a_in;
	reg b_in;

	// Outputs
	wire sum;
	wire carry;

	// Instantiate the Unit Under Test (UUT)
	Half_adder uut (
		.a_in(a_in), 
		.b_in(b_in), 
		.sum(sum), 
		.carry(carry)
	);

	initial begin
		// Initialize Inputs
		a_in = 0;
		b_in = 0;
		
		#10
		a_in=0;
		b_in=1;
		
	   #10
		a_in=1;
		b_in=0;
		
		#10
		a_in=1;
		b_in=1;


		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$finish;

	end
      
endmodule

