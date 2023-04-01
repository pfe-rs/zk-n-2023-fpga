module uart #(
	parameter io = 1'b0
) (input parity, input stoptwo, input CLOCK_50, input [7:0] data, input key, output TX, output [7:0] RECIV, input RX, output LEDR);
	reg [12:0] clk;
	reg [3:0] i;
	reg [7:0] recv;
	reg enable;
	reg enable_possible;
	reg out;
	reg start;
	reg stop;
	reg stopsecond;
	reg led;
	reg reset;
	reg paritydone;
	reg keyp;
	reg par;
	reg [3:0] p;
	assign TX = out;
	assign RECIV = recv;
	assign LEDR = led;
	always @(posedge CLOCK_50) begin
	if(reset == 1) begin
		enable = 1'b0;
		enable_possible = 1'b0;
		start = 1'b1;
		stop = 1'b1;
		stopsecond = 1'b1;
		clk = 13'd0;
		i = 4'd0;
		out = 1'b1;
		led = 1'b0;
		keyp = 1'b1;
		reset = 1'b0;
		paritydone = 1'b0;
	end else begin
		clk = clk + 1;
			if (io == 1) begin
				if(keyp == 1'b1 && key == 1'b0) begin
					enable = 1'b1;
					start = 1'b0;
					stop = 1'b1;
					stopsecond = 1'b1;
					paritydone = 1'b0;
					clk = 13'd0;
					i = 4'd0;
				end
				keyp = key;
				if(clk == 13'd5208) begin
					clk = 13'd0;
					// Ako treba poslati start bit, posalji prvo njega
					if(start == 1'b0) begin
						out = 1'b0;
						start = 1'b1;
					end
					// Ako je u toku slanje, salji
					else if(enable == 1'b1) begin
						if(i <= 4'd8) begin
							out = data[i];
							i = i + 4'd1;
						end
						// Posalji stop bit, parity na kraju i enable = 0 kad svi data bitovi budu poslati
						if(i > 4'd8) begin
							if(parity == 1'b1 && paritydone == 1'b0) begin
								paritydone = 1'b1;
								par = 1'b0;
								for(p = 4'd0; p <= 4'd7; p = p + 4'd1) begin
									par = par + data[p];
								end
								out = par;
							end else begin
								if(stop == 1'b1) begin
									out = 1'b1;
									stop = 1'b0;
								end else begin
									if(stoptwo == 1'b1 && stopsecond == 1'b1) begin
										stopsecond = 1'b0;
									end else begin
										enable = 1'b0;
									end
								end
							end
						end
					end
				end
			end else begin
				if (RX == 1'b0 && enable == 1'b0 && enable_possible == 1'b0) begin
					enable_possible = 1'b1;
					//enable = 1; /////////
					clk = 13'b1010111010100;	// -2604
					i = 4'd0;
					stop = 1'b1;
					stopsecond = 1'b1;
					stop = 1'b1;
					paritydone = 1'b0;
				end
				if (enable_possible == 1'b1 && clk == 1'b0) begin
					if(RX == 1'b0) begin
						led = 1'b1;
						enable = 1'b1;
					end
					enable_possible = 1'b0;
				end
				if(clk == 13'd5208 && enable == 1'b1) begin
					clk = 13'd0;
					if(i <= 4'd7) begin
						recv[i] = RX;
						i = i + 4'd1;
					end 
					else begin
						if(parity == 1'b1 && paritydone == 1'b0) begin
								paritydone = 1'b1;
						end 
						else begin
							if(stop == 1'b1) begin
								stop = 1'b0;
							end 
							else begin
								if(stoptwo == 1'b1 && stopsecond == 1'b1) begin
									stopsecond = 1'b0;
								end 
								else begin
									// Na kraju primanja, procitaj kontrolne signale.
									if(recv == 8'd255) begin
										reset = 1'b1;
									end
									led = 1'b0;
									enable = 1'b0;
								end
							end
						end
					end
				end
			end
		end
	end
endmodule
module projekat(input CLOCK_50, input [3:0] KEY, output TX, input RX, output [9:0] LEDR, output [6:0] HEX0, input [0:0] SW);
	wire [7:0] recv;
	wire [7:0] send;
	wire prazna, prazna2;
	reg [6:0] broj;
	reg parity;
	reg stopbit;
	assign LEDR[8:1] = recv;
	assign HEX0 = broj;
	uart #(1'b1) uart2(parity, stopbit, CLOCK_50, recv, KEY[0], TX, send, RX, prazna2);	// 1 - salji
	uart #(1'b0) uart1(parity, stopbit, CLOCK_50, send, KEY[0], prazna, recv, RX, LEDR[0]);	// 0 - primaj
	always @(posedge CLOCK_50) begin
		case(recv)
							//	  6543210
			8'd48: broj = 7'b1000000;
			8'd49: broj = 7'b0100100;
			8'd50: broj = 7'b0110000;
			8'd51: broj = 7'b0010010;
			8'd52: broj = 7'b0011001;
			8'd53: broj = 7'b0010010; //(5)
			8'd54: broj = 7'b0000010;
			8'd55: broj = 7'b1111000;
			8'd56: broj = 7'b0000000; //(8)
			8'd57: broj = 7'b0011000;
			// Slova:        6543210
			8'd65: broj = 7'b0001000;
			8'd66: broj = 7'b0000011;
			8'd67: broj = 7'b1000110;
			8'd68: broj = 7'b0100001;
			8'd69: broj = 7'b0000110;
			8'd70: broj = 7'b0001110;
			//////////////// 6543210
			8'd72: broj = 7'b0001001;	// H
			8'd73: broj = 7'b1001111; // I
			8'd76: broj = 7'b1000111; // L
			8'd78: broj = 7'b0101011; // N
			8'd254: parity = !parity;
			8'd253: stopbit = !stopbit;
			8'd255: begin
				parity = 1'b0;
				stopbit = 1'b0;
				broj = 7'b1111111;
			end
			default: broj = 7'b1111111;
		endcase
	end
	
endmodule
