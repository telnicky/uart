`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:30:28 04/22/2012
// Design Name:   sender
// Module Name:   C:/Code/uart/final_proj/sender_test.v
// Project Name:  final_proj
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sender
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sender_test;

	// Inputs
	reg clk;
	reg clr;
	reg req;
	reg [7:0] data;

	// Outputs
	wire xmt;
	wire ack;

	// Instantiate the Unit Under Test (UUT)
	sender uut (
		.clk(clk), 
		.clr(clr), 
		.req(req), 
		.data(data), 
		.xmt(xmt), 
		.ack(ack)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		req = 0;
		data = 0;
		
		#20;
		clr = 1;
		
		// Wait 100 ns for global reset to finish
		#100;
		
		req = 1;
		data = 8'b10101010;		
		#20;
		req = 0;
		#1000;
		// Add stimulus here

	end

	always #1 clk = ~clk;  
endmodule

