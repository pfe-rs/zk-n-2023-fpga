module ps2keyboard(
	/**
	 * The PS/2 clock signal.
	 */
	input [0:0] clk,
	/**
	 * Current value on the DATA wire/
	 */
	input [0:0] psdata,
	/*
	 * The display bitmap register.
	 */
	output reg [447:0] disp,
	/*
	 * Key state register.
	 */
	output reg [123:0] keyreg,
	/*
	 * The LEDs which will be used to display the amount of held keys in binary format.
	 */
	output reg [9:0] leds
);
	// set the values of the bitmap register to all ones
	// the displays are inverted, so this turns them all off
	initial begin
		disp = 448'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111;
	end
	// packet bit counter, we read 11 bits of ps2 packets so 4 bits should be enough
	reg [3:0] count;
	// okay i have no idea why this is named data
	reg [10:0] packet;

	// 
	reg [7:0] data;

	// used to store the hardcoded key id; scroll down for individual key ids
	reg [6:0] keyid;
	
	// does the key have a multi-byte code?
	reg [0:0] multibyte;
	// is the key being released?
	reg [0:0] break;

	// the amount of keys currently pressed
	reg [6:0] pressedcount;

	// single-bit registers for storing whether or not special keys had been held
	reg [0:0] shift;
	reg [0:0] ctrl;
	reg [0:0] super;
	reg [0:0] alt;

	// for loop variable; used to count pressed keys for debugging purposes
	// a much more efficient way to count how many keys are being held
	// is to add or subtract a 1 from `pressedcount` each time a key is pressed/released
	integer i;

	// alright, here we go
	// every falling edge of the clock,
	always @(negedge clk) begin
		// increase the current packet bit counter
		count = count + 1;
		// if we think we read enough
		if (count == 11) begin
			// reset the bit position counter back to zero
			count = 0;

			// update the data register with the data bits read
			// this will be the current code to parse
			data = { packet[1], packet[2], packet[3], packet[4],
				packet[5], packet[6], packet[7], packet[8] };

			// parsing individual codes such that
			case (data)
				// E0 indicates there is another byte to read
				'he0: multibyte = 1;
				// F0 indicates the key had been released
				'hf0: break = 1;

				// the following are individual key codes mapped from 0 to 123, inclusive

				/* legend:
				'h00: keyid = MAPPED_ID; // KEY
				  ^^ raw hex keycode        ^^^ refers to the MAPPED_ID

				'h00: keyid = multibyte == 1 ? FIRST : SECOND; // KEY1, KEY2
				  ^^ raw hex keycode           key1 refers to the FIRST mapped id
				                               key2 refers to the SECOND mapped id
				*/
				'h08: keyid = 0; // MYPICTURES
				'h50: keyid = 1; // MEDIA
				'h48: keyid = 2; // MAIL
				'h3f: keyid = 3; // SLEEP

				'h76: keyid = 4; // ESC

				'h05: keyid = multibyte == 1 ? 92 : 5; // F1 fn OFF
				'h3d: keyid = multibyte == 1 ? 93 : 6; // F2 fn OFF, 7
				'h36: keyid = multibyte == 1 ? 94 : 7; // F3 fn OFF, 6
				'h0c: keyid = multibyte == 1 ? 95 : 8;
				'h03: keyid = multibyte == 1 ? 96 : 9;
				'h0b: keyid = multibyte == 1 ? 97 : 10;
				'h83: keyid = multibyte == 1 ? 98 : 11;
				'h0a: keyid = multibyte == 1 ? 99 : 12;
				'h01: keyid = multibyte == 1 ? 100 : 13;
				'h33: keyid = multibyte == 1 ? 101 : 14; // F10 fn OFF, H
				'h78: keyid = multibyte == 1 ? 102 : 15;
				'h07: keyid = multibyte == 1 ? 103 : 16; // F12 fn OFF

				// F1   <-- a comment like this means the key was implemented elsewhere
				'h06: keyid = multibyte == 1 ? 104 : 17; // F2 fn ON, MYMUSIC
				'h04: keyid = 18;
				// F4-F9
				'h09: keyid = 19; // F10 fn ON
				// F11-F12

				'h0e: keyid = 20; // `
				'h16: keyid = 21;
				'h1e: keyid = 22;
				'h26: keyid = 23;
				'h25: keyid = multibyte == 1 ? 105 : 24; // 4, MESSENGER
				'h2e: keyid = 25;
				// 6
				// 7
				'h3e: keyid = 26;
				'h46: keyid = 27;
				'h45: keyid = 28;
				'h4e: keyid = 29;
				'h55: keyid = 30;
				'h66: keyid = 31; // BACKSPACE

				'h0d: keyid = 32; // TAB
				'h15: keyid = multibyte == 1 ? 106 : 33; // Q, MEDIATRACKPREVIOUS
				'h1d: keyid = 34;
				'h24: keyid = 35;
				'h2d: keyid = 36;
				'h2c: keyid = 37;
				'h35: keyid = 38;
				'h3c: keyid = multibyte == 1 ? 107 : 39; // U, LOGOFF
				'h43: keyid = 40;
				'h44: keyid = 41;
				'h4d: keyid = multibyte == 1 ? 108 : 42; // P, MEDIATRACKNEXT
				'h54: keyid = 43;
				'h5b: keyid = 44;
				'h5d: keyid = 45; // \

				'h58: keyid = 46; // CAPSLOCK
				'h1c: keyid = 47;
				'h1b: keyid = 48;
				'h23: keyid = multibyte == 1 ? 109 : 49; // D, MEDIAMUTE
				'h2b: keyid = multibyte == 1 ? 110 : 50; // F, CALCULATOR
				'h34: keyid = multibyte == 1 ? 111 : 51; // G, MEDIAPLAYPAUSE
				// H
				'h3b: keyid = multibyte == 1 ? 112 : 52; // J, MEDIASTOP
				'h42: keyid = 53;
				'h4b: keyid = 54;
				'h4c: keyid = 55;
				'h52: keyid = 56;
				'h5a: keyid = multibyte == 1 ? 113 : 57; // ENTER

				'h12: keyid = 58; // LSHIFT
				'h1a: keyid = 59;
				'h22: keyid = 60;
				'h21: keyid = multibyte == 1 ? 114 : 61; // C, MEDIAVOLUMEDOWN
				'h2a: keyid = 62;
				'h32: keyid = multibyte == 1 ? 115 : 63; // B, MEDIAVOLUMEUP
				'h31: keyid = 64;
				'h3a: keyid = multibyte == 1 ? 116 : 65; // M, WEBHOME
				'h41: keyid = 66;
				'h49: keyid = 67;
				'h4a: keyid = multibyte == 1 ? 117 : 68; // /
				'h59: keyid = 69; // RSHIFT, Nice

				'h14: keyid = multibyte == 1 ? 118 : 70; // LCTRL, RCTRL
				'h1f: keyid = 71; // SUPER
				'h11: keyid = multibyte == 1 ? 119 : 72; // LALT, RALT
				'h29: keyid = 73;
				// RALT
				'h2f: keyid = 74;
				// LCTRL

				'h77: keyid = 75; // NUMLOCK
				// /
				'h7c: keyid = 76;
				'h7b: keyid = 77;
				'h6c: keyid = 78; // NUM7
				'h75: keyid = multibyte == 1 ? 120 : 79; // UPARROW, NUM8 num OFF
				'h7d: keyid = 80;
				'h79: keyid = 81; // +
				'h6b: keyid = multibyte == 1 ? 121 : 82; // LEFTARROW, NUM4 num OFF
				'h73: keyid = multibyte == 1 ? 122 : 83; // MYDOCUMENTS, NUM5 num OFF
				'h74: keyid = multibyte == 1 ? 123 : 84; // RIGHTARROW, NUM6 num OFF
				'h69: keyid = 85; // Nice
				'h72: keyid = multibyte == 1 ? 124 : 86; // DOWNARROW, NUM2 num OFF
				'h7a: keyid = 87;
				// ENTER
				'h70: keyid = 88;
				'h71: keyid = 89;
			endcase

			// update special key states based on 
			shift = keyreg[57] == 1 || keyreg[68] == 1 ? 1 : 0;
			ctrl = keyreg[70] == 1 || keyreg[118] == 1 ? 1 : 0;
			super = keyreg[71] == 1 ? 1 : 0;
			alt = keyreg[72] == 1 || keyreg[119] == 1 ? 1 : 0;

			// if a valid keycode was successfully mapped
			if (keyid != 0) begin
				// and that key was not a special key
				if (break == 0 && keyid != 46 && keyid != 58 && keyid != 69 && keyid != 70 && keyid != 118 && keyid != 71 && keyid != 72 && keyid != 119 && keyid != 75) begin
					// if the key was BACKSPACE
					if (keyid == 31) begin
						// pretend a character was "deleted" by shifting in 7 zeros from the left
						disp = disp >> 7;
						// and then replacing those with ones to store a blank character bitmap
						disp = disp | 448'b1111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
					// else if it was any other key
					end else begin
						// reserve some space for the next character bitmap, potentially eliminating older character bitmaps
						disp = disp << 7;
						// individual key id bitmap mapping
						case (keyid)
							// i have zero clue what is going on here.
							20: disp = disp | 7'b1111110;
							21: disp = disp | 7'b1111001;
							22: disp = disp | 7'b0100100;
							23: disp = disp | 7'b0110000;
							24: disp = disp | 7'b0011001;
							25: disp = disp | 7'b0010010;
							7: disp = disp | 7'b0000010;
							6: disp = disp | 7'b1111000;
							26: disp = disp | 7'b0000000;
							27: disp = disp | 7'b0010000;
							28: disp = disp | 7'b1000000;
							29: disp = disp | (shift == 1 ? 7'b1110111 : 7'b0111111);
							30: disp = disp | 7'b0110111;
							32: disp = (disp << 7) | 14'b11111111111111; // think this is TAB, unsure
							33: disp = disp | 7'b0011000;
							35: disp = disp | 7'b0000110;
							36: disp = disp | 7'b0101111;
							37: disp = disp | 7'b0000111;
							38: disp = disp | 7'b0010001;
							39: disp = disp | 7'b1000001;
							40: disp = disp | 7'b1001111;
							41: disp = disp | 7'b0100011;
							42: disp = disp | 7'b0001100;
							47: disp = disp | 7'b0001000;
							48: disp = disp | 7'b0010010;
							49: disp = disp | 7'b0100001;
							50: disp = disp | 7'b0001110;
							56: disp = disp | (shift == 1 ? 7'b1011101 : 7'b1011111);
							14: disp = disp | 7'b0001001;
							52: disp = disp | 7'b1110001;
							54: disp = disp | 7'b1000111;
							61: disp = disp | 7'b1000110;
							62: disp = disp | 7'b1100011;
							63: disp = disp | 7'b0000011;
							64: disp = disp | 7'b0101011;
							// if the key id was not mapped here, just print a blank character
							default: disp = disp | 7'b1111111;
						endcase
					end
				end
				// update key state in the key register depending on whether or not the key was "broken"
				keyreg[keyid - 1] = break ? 0 : 1;

				// inefficiently counting how many keys are pressed based on their key register states
				// debugging thing
				pressedcount = 0;
				for (i = 0; i < 124; i = i + 1) begin
					if (keyreg[i] == 1) pressedcount = pressedcount + 1;
				end
				// reset the for loop variable
				i = 0;
				// updating the LEDs to display how many keys are pressed in binary format
				leds = pressedcount;

				// if a key was parsed, that probably means we should reset everything back to zero
				multibyte = 0;
				break = 0;
				keyid = 0;
			end

			// reset the packet bits back to zero as well
			packet = 0;
		end

		// (this is in case we havent reached 11 read bits)
		// shift in one zero from the right
		packet = packet << 1;
		// update the LSB of the ps2 packet bits with the current data value from the wire
		packet[0] = psdata;
	end
endmodule
