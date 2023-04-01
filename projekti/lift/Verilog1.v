module konvert(
	
	input [3:0] br, 
	
	output	reg	     [6:0]		HEX0
	//output		     [6:0]		HEX1,
	//output		     [6:0]		HEX2,
	//output		     [6:0]		HEX3,
	//output		     [6:0]		HEX4,
	//output		     [6:0]		HEX5,
	
	
	
);
	always @ (br) begin
		case(br)
		
			4'b0000 : HEX0 = ~7'b0111111;
			4'b0001 : HEX0 = ~7'b0110;
			4'b0010 : HEX0 = ~7'b1011011;
			4'b0011 : HEX0 = ~7'b1001111;
			
			4'b0100 : HEX0 = ~7'b1100110;
			4'b0101 : HEX0 = ~7'b1101101;
			4'b0110 : HEX0 = ~7'b1111101;
			4'b0111 : HEX0 = ~7'b0000111;
			
			4'b1000 : HEX0 = ~7'b1111111;
			4'b1001 : HEX0 = ~7'b1101111;
			4'b1010 : HEX0 = ~7'b1110111;
			4'b1011 : HEX0 = ~7'b1111111;
			
			4'b1100 : HEX0 = ~7'b0111001;
			4'b1101 : HEX0 = ~7'b0111111;
			4'b1110 : HEX0 = ~7'b1111001;
			4'b1111 : HEX0 = ~7'b1110001;
			
			default : HEX0 = ~7'b0;
	 
		endcase
	 end
endmodule