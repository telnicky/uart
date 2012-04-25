`timescale 1ns / 1ps

module receiver_test;

/**
 * CS 3700 Final Project: UART
 * Receiver Circuit Test Module
 * 
 * Travis Elnicky & Michael Scutt
 *
 */

	reg clk, clr, rcv, ack;
	wire req;
	wire [7:0] data;

	receiver uut (.clk(clk), .clr(clr), .rcv(rcv), 
		.ack(ack), .req(req), .data(data));

	initial begin

		$display("testing initialized");

		clk = 0;
		clr = 0;
		rcv = 1;
		ack = 0;

		#20; clr = 1;

		#100;

		rcv = 0;

		#36; rcv = 1;
		#36; rcv = 0;
		#36; rcv = 1;
		#36; rcv = 0;
		#36; rcv = 1;
		#36; rcv = 0;
		#36; rcv = 1;
		#36; rcv = 0;
		#36; rcv = 1;

		#100;

		rcv = 0;

		#36; rcv = 0;
		#36; rcv = 0;
		#36; rcv = 0;
		#36; rcv = 0;
		#36; rcv = 0;
		#36; rcv = 0;
		#36; rcv = 0;
		#36; rcv = 0;
		#36; rcv = 1;

		#100;

		rcv = 0;

		#36; rcv = 1;
		#36; rcv = 1;
		#36; rcv = 1;
		#36; rcv = 1;
		#36; rcv = 1;
		#36; rcv = 1;
		#36; rcv = 1;
		#36; rcv = 1;
		#36; rcv = 1;

		#100;

		rcv = 0;

		#36; rcv = 0;
		#36; rcv = 1;
		#36; rcv = 1;
		#36; rcv = 0;
		#36; rcv = 0;
		#36; rcv = 1;
		#36; rcv = 1;
		#36; rcv = 0;
		#36; rcv = 1;

		#100;

		$display("testing complete");
	end

	always #1 clk = ~clk;

endmodule
