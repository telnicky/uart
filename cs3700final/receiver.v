`timescale 1ns / 1ps

/**
 * CS 3700 Final Project: UART
 * Receiver Circuit Module
 * 
 * Travis Elnicky & Michael Scutt
 *
 */

module receiver(input clk, clr, rcv, ack, output reg req, output reg [7:0] data);

	reg [9:0] divide;
	reg [3:0] count;
	reg enable;
	reg [4:0] state, next_state;

	parameter idle = 0, rcv_start = 1, rcv_bit7 = 2, 
		rcv_bit6 = 3, rcv_bit5 = 4, rcv_bit4 = 5,
		rcv_bit3 = 6, rcv_bit2 = 7, rcv_bit1 = 8,
		rcv_bitp = 9, rcv_bits = 10,
		hs1 = 11, hs2 = 12;

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

		if(!rcv && state == idle)
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

		if(!clr)
			data = 0;
			
		// sample bit at middle of signal
		if(count == 4)
			case(state)
				rcv_bit7: data[7] = rcv;
				rcv_bit6: data[6] = rcv;
				rcv_bit5: data[5] = rcv;
				rcv_bit4: data[4] = rcv;
				rcv_bit3: data[3] = rcv;
				rcv_bit2: data[2] = rcv;
				rcv_bit1: data[1] = rcv;
				rcv_bitp: data[0] = rcv;
			endcase

		case(state)
			hs1: req = 1;
			hs2: req = 0;
			default: req = 0;
		endcase
	end

	// next state logic
	always @(*)
		case(state)
			idle: next_state = !rcv ? rcv_start : state;

			rcv_start: next_state = count == 8 ? rcv_bit1 : state;
			rcv_bit1: next_state = count == 8 ? rcv_bit2 : state;
			rcv_bit2: next_state = count == 8 ? rcv_bit3 : state;
			rcv_bit3: next_state = count == 8 ? rcv_bit4 : state;
			rcv_bit4: next_state = count == 8 ? rcv_bit5 : state;
			rcv_bit5: next_state = count == 8 ? rcv_bit6 : state;
			rcv_bit6: next_state = count == 8 ? rcv_bit7 : state;
			rcv_bit7: next_state = count == 8 ? rcv_bitp : state;
			rcv_bitp: next_state = count == 8 ? rcv_bits : state;
			rcv_bits: next_state = count == 8 ? hs1 : state;

			hs1: next_state = ack ? hs2 : state;
			hs2: next_state = !ack ? idle : state;

			default: next_state = idle;
		endcase

endmodule
