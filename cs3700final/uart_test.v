`timescale 1ns / 1ps

/**
 * CS 3700 Final Project: UART
 * UART Circuit Test Module
 * 
 * Travis Elnicky & Michael Scutt
 *
 */

module uart_uart_sch_tb();

   reg clock, clear, receive;
	wire [7:0] data;
	wire transmit;

   uart UUT (.clock(clock), .clear(clear), .data(data), 
		.receive(receive), .transmit(transmit));

	initial begin

		$display("testing initialized");

		// initialze inputs
		clock = 0;
		clear = 0;
		receive = 1;

		#20; clear = 1;
		#100;

	// case 1
		receive = 0; // start bit

		#36; receive = 1;
		#36; receive = 0;
		#36; receive = 1;
		#36; receive = 0;
		#36; receive = 1;
		#36; receive = 0;
		#36; receive = 1;
		#36; receive = 0;

		#36; receive = 1; // stop bit

		#36; // wait for stop bit to finish
		#18; // handshake
		#36; // start bit
		#18; // catch middle of signal

		if(transmit != 1) $display("error: case 1 bit 1"); #36;
		if(transmit != 0) $display("error: case 1 bit 2"); #36;
		if(transmit != 1) $display("error: case 1 bit 3"); #36;
		if(transmit != 0) $display("error: case 1 bit 4"); #36;
		if(transmit != 1) $display("error: case 1 bit 5"); #36;
		if(transmit != 0) $display("error: case 1 bit 6"); #36;
		if(transmit != 1) $display("error: case 1 bit 7"); #36;
		if(transmit != 0) $display("error: case 1 bit 8"); #36;

		#18; // get out of middle of signal
		#36; //stop bit

	// case 2
		receive = 0;

		#36; receive = 0;
		#36; receive = 0;
		#36; receive = 0;
		#36; receive = 0;
		#36; receive = 0;
		#36; receive = 0;
		#36; receive = 0;
		#36; receive = 0;

		#36; receive = 1;

		#36; #18; #36; #18;
		
		if(transmit != 0) $display("error: case 2 bit 1"); #36;
		if(transmit != 0) $display("error: case 2 bit 2"); #36;
		if(transmit != 0) $display("error: case 2 bit 3"); #36;
		if(transmit != 0) $display("error: case 2 bit 4"); #36;
		if(transmit != 0) $display("error: case 2 bit 5"); #36;
		if(transmit != 0) $display("error: case 2 bit 6"); #36;
		if(transmit != 0) $display("error: case 2 bit 7"); #36;
		if(transmit != 0) $display("error: case 2 bit 8"); #36;

		#18; #36;

	// case 3
		receive = 0;

		#36; receive = 1;
		#36; receive = 1;
		#36; receive = 1;
		#36; receive = 1;
		#36; receive = 1;
		#36; receive = 1;
		#36; receive = 1;
		#36; receive = 1;

		#36; receive = 1;

		#36; #18; #36; #18;
		
		if(transmit != 1) $display("error: case 3 bit 1"); #36;
		if(transmit != 1) $display("error: case 3 bit 2"); #36;
		if(transmit != 1) $display("error: case 3 bit 3"); #36;
		if(transmit != 1) $display("error: case 3 bit 4"); #36;
		if(transmit != 1) $display("error: case 3 bit 5"); #36;
		if(transmit != 1) $display("error: case 3 bit 6"); #36;
		if(transmit != 1) $display("error: case 3 bit 7"); #36;
		if(transmit != 1) $display("error: case 3 bit 8"); #36;

		#18; #36;

	// case 4
		receive = 0;

		#36; receive = 0;
		#36; receive = 1;
		#36; receive = 1;
		#36; receive = 0;
		#36; receive = 0;
		#36; receive = 1;
		#36; receive = 1;
		#36; receive = 0;

		#36; receive = 1;

		#36; #18; #36; #18;
		
		if(transmit != 0) $display("error: case 4 bit 1"); #36;
		if(transmit != 1) $display("error: case 4 bit 2"); #36;
		if(transmit != 1) $display("error: case 4 bit 3"); #36;
		if(transmit != 0) $display("error: case 4 bit 4"); #36;
		if(transmit != 0) $display("error: case 4 bit 5"); #36;
		if(transmit != 1) $display("error: case 4 bit 6"); #36;
		if(transmit != 1) $display("error: case 4 bit 7"); #36;
		if(transmit != 0) $display("error: case 4 bit 8"); #36;

		#18; #36;

		$display("testing complete");
	end

	always #1 clock = ~clock;

endmodule
