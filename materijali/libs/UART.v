module UART(input clk, input rst,
				input [7:0] din, output [7:0] dout, 
				input vin, output rin, 
				output vout, input rout, 
				input rx, output reg tx);
				
	reg [5:0] rxtmr;
	reg [3:0] txtmr;
	reg [8:0] rxword;
	reg [9:0] txword;
	reg [4:0] rxstate;
	reg [4:0] txstate;
	reg rxbuff0;
	reg rxbuff1;
	
	assign vout = rst & (rxstate >= 9);
	assign rin = rst & (txstate == 10);
	assign dout = rxword[7:0];
	
	always @(posedge clk, negedge rst) begin
	
		rxbuff0 <= rx;
		
		
		if(!rst) begin
			rxtmr <= 8;
			txtmr <= 16;
			rxword <= 0;
			rxword <= 0;
			rxstate <= 0;
			txstate <= 10;
			tx <= 1;
			rxbuff1 <= 1;			
		end else begin
		
			rxbuff1 <= (rx == rxbuff0) ? rxbuff0 : rxbuff1;
			
			if(rin && vin) begin
				txtmr <= 15;
				tx <= 0;
				txword <= {2'b11, din};
				txstate <= 0;
			end else begin
				txtmr <= txtmr - 1;
				if(!txtmr && txstate < 10) begin
					 begin
						txword <= txword >> 1;
						tx <= txword[0];
						txstate <= txstate + 1;
					end
				end
			end
			
			if(rout && vout) begin
				rxtmr <= 23;
				rxword <= 0;
				rxstate <= 0;
			end else if (rxstate == 0) begin
				if(rxbuff1 == 0) begin
					rxstate <= 1;
					rxtmr <= 23;
				end
			end else if (rxstate <= 9) begin
				if(!rxtmr) begin
					rxword <= {rxbuff1, rxword[8:1]};
					rxtmr <= 15;
					rxstate <= rxstate + 1;
				end else begin
					rxtmr <= rxtmr - 1;
				end
			end
		end
		
	end
endmodule