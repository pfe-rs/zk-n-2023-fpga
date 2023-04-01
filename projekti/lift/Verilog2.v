module prikaz(input [2:0] tstanje, output reg [9:0] led, output reg [6:0] HEX0, output reg [6:0] HEX1,
output reg [6:0] HEX2, output reg [6:0] HEX3, output reg [6:0] HEX4, output reg [6:0] HEX5, input vrata );

 always @ (tstanje) begin
 
	HEX4 = ~7'b0;
	HEX5 = ~7'b0;
	
	if(vrata) begin
		HEX2= ~7'b110;
		HEX3= ~7'b0110000;
	end
	
	else begin
		HEX2= ~7'b0110000;
		HEX3= ~7'b110;
	end
	
	
	case(tstanje) 
	3'b000 : begin 
		led = 10'b1;
		HEX0 = ~7'b110;
		HEX1 = ~7'b1000000;
	end
	3'b001 : begin
		led = 10'b10;
		HEX0 = ~7'b0100011;
		HEX1 = ~7'b0;
	end
	3'b010 : begin 
		led = 10'b100;
		HEX0 = ~7'b0111111;
		HEX1 = ~7'b0;
	end
	3'b011 : begin
		led = 10'b1000;
		HEX0 = ~7'b0100011;
		HEX1 = ~7'b0;
		
	end
	3'b100 : begin
		led = 10'b10000;
		HEX0 = ~7'b110;
		HEX1 = ~7'b0;
	end
	3'b101 : begin
		led = 10'b1000;
		HEX0 = ~7'b11100;
		HEX1 = ~7'b0;
		
	end
	3'b110 : begin
		led = 10'b10;
		HEX0 = ~7'b11100;
		HEX1 = ~7'b0;
		
	end
	
	default : begin
		HEX0 = ~7'b0;
		HEX1=~7'b0;
	end
	endcase

 end
endmodule
