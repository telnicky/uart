`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:56:19 04/17/2012
// Design Name:   receiver
// Module Name:   U:/Desktop/final_proj/rcv_test.v
// Project Name:  final_proj
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: receiver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rcv_test;

	// Inputs
	reg clk;
	reg clr;
	reg rcv;
	reg ack;

	// Outputs
	wire req;
	wire [7:0] data;

	// Instantiate the Unit Under Test (UUT)
	receiver uut (
		.clk(clk), 
		.clr(clr), 
		.rcv(rcv), 
		.ack(ack), 
		.req(req), 
		.data(data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		rcv = 1;
		ack = 0;
		
		#20;
		clr = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		rcv = 0;
		
		#36; rcv = 0;
		#36; rcv = 1;
		#36; rcv = 0;
		#36; rcv = 0;
		#36; rcv = 1;
		#36; rcv = 0;
		#36; rcv = 0;
		#36; rcv = 0;
		#36; rcv = 1;
		
		#100;
		
	end
 
	always #1 clk = ~clk;
endmodule

