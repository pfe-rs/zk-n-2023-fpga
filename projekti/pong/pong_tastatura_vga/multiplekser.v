module multipleks(input CLK, output reg [15:0] gpio, input [3:0] x, input[3:0] y);



reg[3:0] i;


always @(posedge CLK) begin
	//x = 0;
	//y = 1;
	gpio[15:8] = 8'hff; // zapisi na ekran
	gpio[7:0] = 8'd0;
	
	
	gpio[8+x] = 0;
	gpio[y] = 1;
	
end
endmodule

module red_sweep(input CLK, input [3:0] pom1, input [3:0] pom2 ,output reg[3:0] x, output reg[3:0] y,input [3:0] x_b,input [3:0] y_b); 
reg[3:0] i = 4'd0;
reg [0:0] which;

always @(posedge CLK)begin

	if(y == 0 && which==0) begin
		if(x > pom1 + 1) begin
			x = pom2;
			y = 7;
			i = 0;
		end
		
		else begin
			x = pom1 + i;
			i = i+1;
		end
		
	end
	
	if(y == 7 && which==0) begin
		if(x > pom2 + 1) begin
			x = x_b;
			y = y_b;
			i = 0;
			which=1;
		end
		else begin
			x = pom2 + i;
			i = i+1;
		end	
	end
	else if (which==1)begin
		which=0;
		x=pom1;
		y=0;
		
	
	end

	/*
	x = x + 1;
	if (x > 7) begin
		x = 0;
		y = y + 1;
		if (y > 7) begin
			y = 0;
		end
	end
	*/
end
	

endmodule


module keys(input CLK, output reg [3:0] pom1, output reg [3:0] pom2,input [7:0] keys, input [3:0]game,input [0:0]first,output reg [3:0] game2);

reg[3:0] plus = 4'd2; // 
always @(posedge CLK) begin


if (first==0)begin
	pom1=plus;
	pom2=plus;
	//game2=0;
	//first=1;
end
	if (game2 == 0 && (keys[7:0] < 8'b11111111) ) game2 = 1;
	else game2=0;
	if ((keys[0] == 0 || keys[1] == 0) && pom2>0)begin
		
		pom2=pom2-1;
		
		
	end
	if ((keys[2] == 0 || keys[3] == 0) && pom2<5)begin
		
		pom2=pom2+1;
		
		
	end
	if ((keys[4] == 0 || keys[5] == 0) && pom1>0)begin
		
		pom1=pom1-1;
		
		
	end
	if ((keys[6] == 0 || keys[7] == 0) && pom1<5)begin
		
		pom1=pom1+1;
			
	end
	
	
end
endmodule

module rand(
  input  clk,
    input  rst_n,

  output reg [4:0] smer
);
wire feedback = smer[4] ^ smer[1] ;

always @(posedge clk or negedge rst_n)
  if (~rst_n) 
    smer<= 4'hf;
  else
    smer <= {smer[3:0], feedback} ;

endmodule




/*
module rand(input CLK, output reg [3:0] smer);

integer	bit;
integer lfsr=32'd26;
integer period = 0;

always @(posedge CLK) begin

//smer = 2;
//	lfsr =  ;
        bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) ;
        lfsr = (lfsr >> 1) | (bit << 15);
        period=period+1;
	for(period = 0;period < 15; period = period +1)
	 begin
	 
        bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) ;
        lfsr = (lfsr >> 1) | (bit << 15);
       
	 end
	 
	 
	 smer = lfsr % 6;
	
end
endmodule
*/

module ball(input CLK, input [3:0] smer,output reg [3:0] x_b,output reg [3:0] y_b,input [3:0]pom1,input [3:0]pom2,output reg [3:0] poeni1,output reg [3:0] poeni2, output reg [3:0]game,output reg[0:0] first,input [3:0] game2);

reg [3:0] prvi_s;

integer px=0;
integer py=0;
integer br=0;
always @(posedge CLK) begin
if (game2 ==1 && game != 0)begin 
	game = 0;
	poeni1 = 0;
	poeni2 = 0;
	end
if(game == 0)begin
if (first==0)begin
	prvi_s=smer % 2 + 2;
	game=0;
	/*
	case (smer)
	0: begin
		x_b=4;
		y_b=4;
	end
	1: begin
		x_b=4;
		y_b=3;
	end

	2: begin
		x_b=3;
		y_b=3;
	end
	3,4: begin
		x_b=3;
		y_b=4;
	end
	4,5: begin
		x_b=4;
		y_b=4;
	end*/
	x_b =3;
	y_b = 3;

	//endcase
	br=br+1;
	if(br>12)begin
		first=1;
		br=0;
	end
end
else begin
	// pomera
		
	if (x_b==7 || x_b==0)
			begin
			prvi_s = (prvi_s + 4)% 8;
			end

	if(prvi_s%2==0)px=-1;
	else px=1;
	case (prvi_s)
		0,1:py=-1;
		2,3:py=0;
		4,5:py=1;
	endcase

	
	//
	x_b=x_b+py;
	y_b=y_b+px;
	
	if(y_b==0)begin
		case (x_b)
			pom1:prvi_s=1;
			pom1+1:prvi_s=3;
			pom1+2:prvi_s=5;
			default:
					begin
				poeni2=poeni2+1;
				if (poeni2 > 3) begin
					poeni2 = 11;
					poeni1 = 12;
					game=1;
				end
				first=0;
			
			end
		endcase
		end
		
		if(y_b==7)begin
		case (x_b)
			pom2:prvi_s=0;
			pom2+1:prvi_s=2;
			pom2+2:prvi_s=4;
			default:
				begin
				poeni1=poeni1+1;
				if (poeni1 > 3) begin
					poeni1 = 11;
					poeni2 = 12;
					
					game=1;
					end
				first=0;
				//game=1;
				end
		endcase
		end
		



end

end
end
endmodule

//,input [3:0] x_b,input [3:0] y_b
