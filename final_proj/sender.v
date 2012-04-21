`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Travis Elnicky 
// Engineer: Michael Scutt
//
//////////////////////////////////////////////////////////////////////////////////
module sender(input clk, clr, req, input [7:0] data, output reg xmt, output reg ack);

	reg [9:0] divide;
	reg [3:0] count;
	reg enable;
	
	reg [4:0] state, next_state;
	
	parameter idle = 0,
				 xmt_start = 1,
				 xmt_bit7 = 2,
				 xmt_bit6 = 3,
				 xmt_bit5 = 4,
				 xmt_bit4 = 5,
				 xmt_bit3 = 6,
				 xmt_bit2 = 7,
				 xmt_bit1 = 8,
				 xmt_bitp = 9,
				 xmt_bits1 = 10,
				 xmt_bits2 = 11,
				 hs1 = 12,
				 hs2 = 13;

	// divided clock
	always @(posedge clk)
			if(divide == 579) begin // 50M / (9 * 9600) gives ~9 ticks/bit

				divide = 0;
				enable = 1;
			end

			else begin

				divide = divide + 1;
				enable = 0;
			end

	// present state logic
	always @(posedge clk) begin

		// count 9 ticks per bit
		if(enable)
			count = count < 9 ? count + 1 : 0;

		if(!clr)
			state = idle;

		// handshake
		else if(req && state == idle)
			state = hs1;

		else if (state == hs1 && !req)
			state = next_state;

		// move through bit states
		else if(count == 8 && state != hs1)			
			state = next_state;

		else
			state = state;		
	end

	always @(*)
		if(count == 0)
			case(state)
				xmt_bit7: xmt = data[7];
				xmt_bit6: xmt = data[6];
				xmt_bit5: xmt = data[5];
				xmt_bit4: xmt = data[4];
				xmt_bit3: xmt = data[3];
				xmt_bit2: xmt = data[2];
				xmt_bit1: xmt = data[1];
				xmt_bitp: xmt = data[0];
				xmt_start: xmt = 1'b0;
				xmt_bits1: xmt = 1'b1;
				xmt_bits2: xmt = 1'b1;
				default: xmt = 1;
			endcase

	always @(*)
		case(state)
			hs1: ack = 1;
			hs2: ack = 0;
			default: ack = 0;
		endcase

	// next state logic
	always @(*)
		case(state)
			idle:      next_state = idle;
			hs1:		  next_state = hs2;
			hs2:		  next_state = xmt_start;
			xmt_start: next_state = xmt_bit1;
			xmt_bit1:  next_state = xmt_bit2;
			xmt_bit2:  next_state = xmt_bit3;
			xmt_bit3:  next_state = xmt_bit4;
			xmt_bit4:  next_state = xmt_bit5;
			xmt_bit5:  next_state = xmt_bit6;
			xmt_bit6:  next_state = xmt_bit7;
			xmt_bit7:  next_state = xmt_bitp;
			xmt_bitp:  next_state = xmt_bits1;
			xmt_bits1:  next_state = xmt_bits2;
			xmt_bits2:  next_state = idle;
			default:   next_state = idle;
		endcase

endmodule
