`timescale 1ns / 1ps

/**
 * CS 3700 Final Project: UART
 * Sender Circuit Module
 * 
 * Travis Elnicky & Michael Scutt
 *
 */

module sender(input clk, clr, req, input [7:0] data, output reg xmt, output reg ack);

	reg [9:0] divide;
	reg [3:0] count;
	reg enable;
	reg [4:0] state, next_state;
	reg [7:0] save;

	parameter idle = 0, xmt_start = 1, xmt_bit7 = 2,
		xmt_bit6 = 3, xmt_bit5 = 4, xmt_bit4 = 5,
		xmt_bit3 = 6, xmt_bit2 = 7, xmt_bit1 = 8,
		xmt_bitp = 9, xmt_bits1 = 10, xmt_bits2 = 11,
		hs1 = 12, hs2 = 13;

	// clock divider
	always @(posedge clk) begin
	
			if(divide == 579) begin // gives ~9 ticks per bit

				divide = 0;
				enable = 1;
				count = count >= 8 ? 0 : count + 1;
			end

			else begin

				divide = divide + 1;
				enable = 0;
			end

			if(state == idle || state == hs1 || state == hs2)
				count = 0;

			if(!clr)
				{enable, divide, count} = 0;
		end

	// present state logic
	always @(posedge clk)
		if(!clr)
			state = idle;

		else if(enable)
			state = next_state;

	// output logic
	always @(posedge clk) begin

		xmt = 1;

		case(state)
			xmt_bit7: xmt = save[7];
			xmt_bit6: xmt = save[6];
			xmt_bit5: xmt = save[5];
			xmt_bit4: xmt = save[4];
			xmt_bit3: xmt = save[3];
			xmt_bit2: xmt = save[2];
			xmt_bit1: xmt = save[1];
			xmt_bitp: xmt = save[0];
			xmt_start: xmt = 0;
			xmt_bits1: xmt = 1;
			xmt_bits2: xmt = 1;
			default: xmt = 1;
		endcase

		case(state)
			hs1: begin save = data; ack = 1; end
			hs2: ack = 0;
			default: ack = 0;
		endcase
	end

	// next state logic
	always @(*)
		case(state)
			idle: next_state = req ? hs1 : state;

			hs1: next_state = !req ? hs2 : state;
			hs2: next_state = !ack ? xmt_start : state;

			xmt_start: next_state = count == 8 ? xmt_bit1 : state;
			xmt_bit1: next_state = count == 8 ? xmt_bit2 : state;
			xmt_bit2: next_state = count == 8 ? xmt_bit3 : state;
			xmt_bit3: next_state = count == 8 ? xmt_bit4 : state;
			xmt_bit4: next_state = count == 8 ? xmt_bit5 : state;
			xmt_bit5: next_state = count == 8 ? xmt_bit6 : state;
			xmt_bit6: next_state = count == 8 ? xmt_bit7 : state;
			xmt_bit7: next_state = count == 8 ? xmt_bitp : state;
			xmt_bitp: next_state = count == 8 ? xmt_bits1 : state;
			xmt_bits1: next_state = count == 8 ? xmt_bits2 : state;
			xmt_bits2: next_state = count == 8 ? idle : state;

			default: next_state = idle;
		endcase

endmodule
