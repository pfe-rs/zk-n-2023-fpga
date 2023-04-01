
module projekat(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// PS2 //////////
	inout 		          		PS2_CLK,
	inout 		          		PS2_CLK2,
	inout 		          		PS2_DAT,
	inout 		          		PS2_DAT2,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS,
	input								RX,
	output							TX
);



//=======================================================
//  REG/WIRE declarations
//=======================================================


//=======================================================
//  Structural coding
//======================	=================================
	
	wire clk;
	wire [31:0] fsin;
	wire [31:0] fsout;
	clkdiv clk2(.clk(CLOCK_50), .clkout(clk));
	/*
	reg [7:0] u_din;
	wire [7:0] u_dout;
	wire u_vin;
	wire u_rin;
	wire u_vout;
	reg u_rout;
	wire u_rx;
	wire u_tx;
	wire u_rst;
	
	UART uart(.clk(clk), .rst(u_rst),
				.din(u_din), .dout(u_dout), 
				.vin(u_vin), .rin(u_rin), 
				.vout(u_vout), .rout(u_rout), 
				.rx(u_rx), .tx(u_tx));
				
	reg [7:0] fsin;
	wire [7:0] fsout;
	wire fvin;
	wire frin;
	wire fvout;
	reg frout;
	wire frst;*/
				
	filter filt(.clk(clk), .sin(fsin), .sout(fsout));
					
	Filter_interface interface(.clk(clk), .synR(!KEY[0]), .outSample(fsin), .inSample(fsout));
	
	/*initial begin
		$readmemd("filename.txt", u_din);
	end
				
	integer cnt = 0;

	always @(posedge clk) begin
		if (fvout) begin
		   case (cnt)
				0: u_din <= fsout[7:0];
				1: u_din <= fsout[15:8];
				2: u_din <= fsout[23:16];
				3: u_din <= fsout[31:24];
			endcase

		  cnt <= (cnt == 3) ? 0 : cnt + 1;
		  frout <= (cnt == 3) ? 1 : 0;
	  end
	end
	
	
	always @(posedge clk) begin
		if (u_vout) begin
		   case (cnt)
				0: fsin <= u_dout[7:0];
				1: fsin <= u_dout[15:8];
				2: fsin <= u_dout[23:16];
				3: fsin <= u_dout[31:24];
			endcase

		  cnt <= (cnt == 3) ? 0 : cnt + 1;
		  u_rout <= (cnt == 3) ? 1 : 0;
	  end
	end*/
	
	

		
				
	/*			
	reg [10:0] a = {20'd10000,20'd39765,20'd86759,20'd125876,20'd131927,20'd102782,20'd59798,20'd25504,20'd7605,20'd1429,20'd128};
	reg [10:0] b = {20'd1133,20'd8558,20'd31228,20'd71963,20'd115533,20'd134742,20'd115533,20'd71963,20'd31228,20'd8558,20'd1133};
	
	integer n = 200;
	integer m = 11;

	reg [6:0] y = {16'd0, 16'd0, 16'd0, 16'd0, 16'd0, 16'd0, 16'd0};

	always @ begin
		integer i;
		integer j;
		integer n1 = 7;
		for(i=0; i<7; i=i+1)begin
			y[i] = b [0]*x[i];
			for(j = 1; j<=i && j<2; j = j +1)begin
				y[i] = y[i]+b[j]*x[i-j];
				y[i] = y[i] - a[j]*y[i-j];
			end
			y[i] = y[i]/a[0];
				
		end
	end*/
	

	
	
	
endmodule
