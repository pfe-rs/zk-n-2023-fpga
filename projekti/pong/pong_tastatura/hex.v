module hex(input [3:0] num,output reg [6:0] out);

always @(*) begin
case(num)

	4'd0  :  out =  7'b1000000;
	4'd1  :  out = ~7'b0000110;
	4'd2  :	out = ~7'b1011011;
	4'd3  :	out = ~7'b1001111;
	4'd4  :	out = ~7'b1100110;
	4'd5  : 	out = ~7'b1101101;
	4'd6  :	out = ~7'b1111101;
	4'd7  :	out = ~7'b0000111;
	4'd8  :	out = ~7'b1111111;
	4'd9  :	out = ~7'b1101111;
	4'd10 :	out = ~7'b1110111;
	////
	4'd11 : 	out = ~7'b1110011; // pobeda
	4'd12 :	out = ~7'b0111101; //gubitak
	default: out = ~7'b0000000;
	//0111101
	//4'd13 :	out = ~7'b1011110;
	//4'd14 :	out = ~7'b1111001;
	//4'd15 : 	out = ~7'b;
	
	endcase
	end
endmodule

