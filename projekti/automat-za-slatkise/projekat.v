module projekat(
    //////////// CLOCK //////////
    input                    CLOCK2_50,
    input                    CLOCK3_50,
    input                    CLOCK4_50,
    input                    CLOCK_50,

    //////////// SEG7 //////////
    output reg      [6:0]    HEX0,
    output reg      [6:0]    HEX1,
    output reg      [6:0]    HEX2,
    output reg      [6:0]    HEX3,
    output reg      [6:0]    HEX4,
    output reg      [6:0]    HEX5,

    //////////// KEY //////////
    input            [3:0]   KEY,

    //////////// LED //////////
    output           [9:0]   LEDR,

    //////////// PS2 //////////
    inout                    PS2_CLK,
    inout                    PS2_CLK2,
    inout                    PS2_DAT,
    inout                    PS2_DAT2,

    //////////// SW //////////
    input            [9:0]   SW,

    //////////// VGA //////////
    output                    VGA_BLANK_N,
    output          [7:0]    VGA_B,
    output                    VGA_CLK,
    output          [7:0]    VGA_G,
    output                    VGA_HS,
    output          [7:0]    VGA_R,
    output                    VGA_SYNC_N,
    output                    VGA_VS
);

    //////////// REG/WIRE declarations //////////
    reg [7:0] tren_stanje = 0;
    reg [7:0] br_bananica = 0;

	 

    //////////// Procedural Block //////////

localparam stanje0 = 4'd0;
localparam stanje5 = 4'd1;
localparam stanje10 = 4'd2;
localparam stanje15 = 4'd3;
localparam pare0 = 4'd5;
localparam reset = 4'd6;
localparam change_5 = 4'd7;
localparam change_10 = 4'd8;
localparam change_15 = 4'd9;
//keys<=KEY;

always @ (negedge CLOCK_50) begin
	if (!KEY[3]) begin
	
		if (tren_stanje == stanje0) begin
			tren_stanje = stanje5; end
		else if (tren_stanje == stanje5) begin
			tren_stanje = stanje10; end
		else if (tren_stanje == stanje10) begin
			tren_stanje = stanje15; end
		else if (tren_stanje == stanje15) begin
			br_bananica = br_bananica+1;
			tren_stanje = stanje0; 
		end
		
	end
	
	if (!KEY[2]) begin
		
		if (tren_stanje == stanje0) begin
			tren_stanje = stanje10; end
		else if (tren_stanje == stanje10) begin
			br_bananica = br_bananica+1;
			tren_stanje = stanje0;
		end
		else if (tren_stanje == stanje5) begin
			tren_stanje = stanje15;
		end
		else if (tren_stanje == stanje15) begin
		tren_stanje = change_5;
		br_bananica = br_bananica+1;
		tren_stanje = pare0;
		end
		
		
	end
	if (!KEY[1]) begin
	
		if (tren_stanje == stanje0) begin
			br_bananica = br_bananica+1;
			tren_stanje = stanje0;
		end
		else if (tren_stanje == stanje5) begin
			tren_stanje = change_5;
			br_bananica = br_bananica+1;
			tren_stanje = pare0;
		end
		else if (tren_stanje == stanje10) begin
			tren_stanje = change_10;
			br_bananica = br_bananica+1;
			tren_stanje = pare0;
		end
		else if (tren_stanje == stanje15) begin
			tren_stanje = change_15;
			br_bananica = br_bananica+1;
			tren_stanje = pare0;
		end
		
	end
	
	if (!KEY[0]) begin
		tren_stanje = reset;
		tren_stanje = stanje0;
	end

end


always @(*) begin
	HEX5 = 7'b1111111;
	HEX4 = 7'b1111111;
	case (tren_stanje)
	4'd0 : HEX0 = ~7'b0111111;
	4'd6 : HEX0 = ~7'b0111111;
	4'd7 : HEX0 = ~7'b1101101;
	4'd8 : HEX0 = ~7'b0111111;
	4'd9 : HEX0 = ~7'b1101101;
	endcase;
	case (tren_stanje)
	4'd0 : HEX1 = ~7'b0111111;
	4'd6 : HEX1 = ~7'b0111111;
	4'd7 : HEX1 = ~7'b0111111;
	4'd8 : HEX1 = ~7'b0000110;
	4'd9 : HEX1 = ~7'b0000110;
	endcase;
	case (tren_stanje)
	4'd0 : HEX2 = ~7'b0111111;
	4'd1 : HEX2 = ~7'b1101101;
	4'd2 : HEX2 = ~7'b0111111;
	4'd3 : HEX2 = ~7'b1101101;
	4'd4 : HEX2 = ~7'b0111111;
	4'd5 : HEX2 = ~7'b0111111;
	4'd6 : HEX2 = ~7'b0111111;
	endcase;
	case (tren_stanje)
	4'd0 : HEX3 = ~7'b0111111;
	4'd1 : HEX3 = ~7'b0111111;
	4'd2 : HEX3 = ~7'b0000110;
	4'd3 : HEX3 = ~7'b0000110;
	4'd5 : HEX3 = ~7'b0111111;
	4'd6 : HEX3 = ~7'b0111111;
	endcase;
	//case(br_bananica) 
	//4'b0000 : HEX4 = ~7'b0111111;
	//4'b0001 : HEX4 = ~7'b0000110;
	//4'b0010 : HEX4 = ~7'b1011011;
	//4'b0011 : HEX4 = ~7'b1001111;
	//4'b0100 : HEX4 = ~7'b1100110;
	//4'b0101 : HEX4 = ~7'b1101101;
	//endcase;
	end
	
	reg [3:0] light;
	reg [3:0] stanje_p = 4'b1111;
	assign LEDR = light;

	always @ (negedge CLOCK_50) begin
	
	  if (KEY[0] == 1 && stanje_p[0] == 0) begin
		 light <= 4'b0000;
		 stanje_p[0] <= 1;
	  end
			else if (KEY[0] == 0 && stanje_p[0] == 1)
			 stanje_p[0] <= KEY[0];

	  if (KEY[1] == 1 && stanje_p[1] == 0)
	  begin
		 light <= 4'b0001;
		 stanje_p[1] <= 1;
	  end
	  
		  else if (KEY[1] == 0 && stanje_p[1] == 1)
			 stanje_p[1] <= KEY[1];

	  if (KEY[2] == 1 && stanje_p[2] == 0)
	  begin
		 light <= 4'b0010;
		 stanje_p[2] <= 1;
	  end
		  else if (KEY[2] == 0 && stanje_p[2] == 1)
			 stanje_p[2] <= KEY[2];

	  if (KEY[3] == 1 && stanje_p[3] == 0)
	  begin
		 light <= 4'b0100;
		 stanje_p[3] <= 1;
	  end
		  else if (KEY[3] == 0 && stanje_p[3] == 1)
			 stanje_p[3] <= KEY[3];
	end


	endmodule

	
	
	