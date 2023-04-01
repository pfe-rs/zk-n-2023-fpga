module projekat1(

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
	output		          		VGA_VS
);
	assign LEDR = 10'hAA;
	endmodule


	
/*BROJEVI NA LAMPICAMA*/
module displej(output [6:0] lamp, input [7:0] mat);
	reg [6:0] pom;
	assign lamp = pom;
always @(*) begin
	case (mat)
		8'd0: pom=7'b1000000;
		8'd1: pom=7'b1111001;
		8'd2: pom=7'b0100100;
		8'd3: pom=7'b0110000;
		8'd4: pom=7'b0011001;
		8'd5: pom=7'b0010010;
		8'd6: pom=7'b0000010;
		8'd7: pom=7'b1111000;
		8'd8: pom=7'b0000000;
		8'd9: pom=7'b0011000;
	endcase
	end	
endmodule

/*UGASEN DISPLEJ*/
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
	input 		     [9:0]		SW,

	//////////// KEY //////////
	input 		     [3:0]		KEY
);
	/*wire [6:0] ugasen = 7'b1111111;
	assign HEX0=ugasen;
	assign HEX1=ugasen;*/

	
	
/*UNOS VREDNOSTI MATRICA*/
	localparam r1=3;
	localparam k1=3;
	localparam r2=3;
	localparam k2=3;

	reg [7:0] mat1[r1-1:0][k1-1:0];
	reg [7:0] mat2[r2-1:0][k2-1:0];
	reg [7:0] mat[r1-1:0][k2-1:0];

always @(*) begin	
	integer i;
	integer j;
	integer l;

	/*for (i=0; i<r1; i=i+1) begin
			for (j=0; j<k1; j=j+1) begin
				mat1[i][j]=4'd2;
			end
	end
	for (i=0; i<r2; i=i+1) begin
			for (j=0; j<k2; j=j+1) begin
				mat2[i][j]=4'd1;
			end
	end*/

	/*
	mat1[0][0] = 8'd0;
	mat1[0][1] = 8'd1;
	mat1[1][0] = 8'd2;
	mat1[1][1] = 8'd3;

	mat2[0][0] = 8'd1;
	mat2[0][1] = 8'd1;
	mat2[1][0] = 8'd1;;
	mat2[1][1] = 8'd1;
	*/

	
		
/*MNOZENJE MATRICA*/	
	for (i=0; i<r1; i=i+1) begin
			for (j=0; j<k2; j=j+1) begin
				mat[i][j]=0;
				for (l=1;  l<=k1; l=l+1) begin
						 mat[i][j]=mat[i][j]+ mat1[i][l-1]*mat2[l-1][j];
				end
			end
	end	
end
	
	

/*ISPIS MATRICE*/
	displej dis1(HEX5, mat[0][0]);
	displej dis2(HEX4, mat[0][1]);
	displej dis3(HEX3, mat[0][2]);
	displej dis4(HEX2, mat[1][0]);
	displej dis5(HEX1, mat[1][1]);
	displej dis6(HEX0, mat[1][2]);

	
	
	wire [71:0] niz1;
	wire [71:0] niz2;	
	reg [71:0] niz;
always @(*) begin	
	integer i;
	integer j;
	integer l;	
		
	for(i = 0; i<r1; i=i+1) begin
		for (j = 0; j<k1; j=j+1) begin
			mat1[i][j]=niz1[(i*k1+j)*8+:8] ;
		end
	end	
	
	
	for(i = 0; i<r2; i=i+1) begin
		for (j = 0; j<k2; j=j+1) begin
			mat2[i][j]=niz2[(i*k2+j)*8+:8];
		end
	end	
				
	for(i = 0; i<r1; i=i+1) begin
		for (j = 0; j<k2; j=j+1) begin
			niz[(i*k2+j)*8+:8] = mat[i][j];
		end
	end					
end

		
Matrix_interface matrix(
	CLOCK2_50, 
	niz1, 
	niz2,
	niz
);

endmodule