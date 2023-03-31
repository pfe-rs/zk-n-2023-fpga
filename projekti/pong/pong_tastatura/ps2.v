module ps2parse(
	input [0:0] clk,
	input [0:0] psdata,
	output reg [7:0] buttons,
	output reg [123:0] keyreg
);
	initial begin
		buttons = 4'h0;
	end

	reg [3:0] count;
	reg [10:0] data;

	reg [7:0] code;

	reg [6:0] keyid;
	
	reg [0:0] multibyte;
	reg [0:0] break;

	reg [6:0] pressedcount;
	
	reg [3:0] ptr;
	always @(negedge clk) begin
		count = count + 1;
		if (count == 11) begin
			count = 0;

			code = { data[1], data[2], data[3], data[4],
				data[5], data[6], data[7], data[8] };

			case (code)
				'he0: multibyte = 1;
				'hf0: break = 1;

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

				// F1
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
				'h59: keyid = 69; // RSHIFT

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
				'h75: keyid = multibyte == 1 ? 120 : 79; // NUM8 num OFF, UPARROW
				'h7d: keyid = 80;
				'h79: keyid = 81; // +
				'h6b: keyid = multibyte == 1 ? 121 : 82; // NUM4 num OFF, LEFTARROW
				'h73: keyid = multibyte == 1 ? 122 : 83; // NUM5 num OFF, MYDOCUMENTS
				'h74: keyid = multibyte == 1 ? 123 : 84; // NUM6 num OFF, RIGHTARROW
				'h69: keyid = 85; // Nice
				'h72: keyid = multibyte == 1 ? 124 : 86; // NUM2 num OFF, DOWNARROW
				'h7a: keyid = 87;
				// ENTER
				'h70: keyid = 88;
				'h71: keyid = 89;
			endcase

			if (keyid != 0) begin
				keyreg[keyid - 1] = break ? 0 : 1;
				
				case (keyid)
					// W, A, S, D
					34: ptr = 1;
					47: ptr = 2;
					48: ptr = 3;
					49: ptr = 4;
					// UPARROW, LEFTARROW, RIGHTARROW, DOWNARROW
					120: ptr = 5;
					121: ptr = 6;
					123: ptr = 7;
					124: ptr = 8;
				endcase
				if (ptr != 0) buttons[ptr - 1] = break ? 1 : 0;
				ptr = 0;

				multibyte = 0;
				break = 0;
				keyid = 0;
			end
			
			data = 0;
		end

		data = data << 1;
		data[0] = psdata;
	end
endmodule
