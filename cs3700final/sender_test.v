`timescale 1ns / 1ps

module sender_test;

/**
 * CS 3700 Final Project: UART
 * Sender Circuit Test Module
 * 
 * Travis Elnicky & Michael Scutt
 *
 */

	reg clk, clr, req;
	reg [7:0] data;
	wire xmt, ack;

	sender uut (.clk(clk), .clr(clr), .req(req), 
		.data(data), .xmt(xmt), .ack(ack));

	initial begin

		$display("testing initialized");

		clk = 0;
		clr = 0;
		req = 0;
		data = 0;
		
		#20; clr = 1;

		#100;

		req = 1;
		data = 8'b10101010;

		#20; req = 0;

		#1000;

		$display("testing complete");
	end

	always #1 clk = ~clk;

endmodule
