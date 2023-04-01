module promenaStanja(output reg [2:0] sstanje, output reg [2:0] tstanje, output reg [4:0] sticiDo, 
input clk, input [3:0] KEY, input [35:0] GPIO_1, input [1:0] SW, output reg vrata);

reg vreme;
reg [25:0] br;

always @ (posedge clk) begin
	if(br == 26'd50000000) begin
		vreme = 1'b1;
		br = 26'd0;
	end
	else begin
		br = br + 26'd1;
		vreme = 1'b0;
	end
end	


always @ (posedge clk)begin
	if(!GPIO_1) begin
		sticiDo[4] = 1'b1;
		vrata = 0;
	end
	if(!KEY[0]) begin
		sticiDo[3] = 1'b1;
		vrata = 0;
	end
	if(!KEY[1]) begin
		sticiDo[2] = 1'b1;
		vrata = 0;
	end
	if(!KEY[2]) begin
		sticiDo[1] = 1'b1;
		vrata = 0;
	end
	if(!KEY[3]) begin
		sticiDo[0] = 1'b1;
		vrata = 0;
	end
if(vreme)begin
  case(tstanje) 
  
  //spratovi
  
  //podrum
	3'b000 : begin
		if(sticiDo[0] || sticiDo[3] || sticiDo[4])begin
			sstanje = 3'b001;
			vrata=0;
		end
		else begin 
			sstanje = tstanje;
			vrata=1;
		end
		if(SW[1])begin
			sticiDo[4]=1'b1;
		end
		sticiDo[1] = 1'b0;
		sticiDo[2] = 1'b0;
	end
	
	
	//prizemlje
	3'b010 : begin
		if(sticiDo[0] || sticiDo[4]) begin
			sstanje = 3'b011;
			vrata=0;
		end
		else if(sticiDo[1] || sticiDo[2]) begin
			sstanje = 3'b110;
			vrata = 0;
		end
		else begin
			sstanje = tstanje;
			vrata=1;
		end
		if(sticiDo[3]) begin
			sticiDo[3] = 1'b0;
			vrata = 1;
		end
	end
	
	
	//sprat
	3'b100 : begin
		if(sticiDo[1] || sticiDo[2] || sticiDo[3]) begin
			sstanje = 3'b101;
			vrata = 0;
		end
		else begin
			sstanje = tstanje;
			vrata = 1;
		end
		if(SW[1])begin
			sticiDo[2]=1'b1;
		end
		sticiDo[0] = 1'b0;
		sticiDo[4] = 1'b0;
	end
	
	
	//medju stanje
	
	//na gore, 0 i 1
	3'b001 : begin
		if(sticiDo[0] || sticiDo[3] || sticiDo[4]) sstanje = 3'b010;	
		else sstanje = tstanje;
		sticiDo[0] = 1'b0;
		vrata = 0;
	end
	
	//na gore 1 i 2
	3'b011 : begin
		if(sticiDo[0] || sticiDo[4]) sstanje = 3'b100;
		else sstanje = tstanje;
		sticiDo[0] = 1'b0;
		vrata = 0;
	end
	
	//na dole 2 i 1
	3'b101 : begin
		if(sticiDo[1] || sticiDo[2] || sticiDo[3]) sstanje = 3'b010;
		else sstanje = tstanje;
		sticiDo[1] = 1'b0; 
		vrata = 0;
	end
	
	//na dole 1 i 0
	3'b110 : begin
		if(sticiDo[1] || sticiDo[2]) sstanje = 3'b000;
		else sstanje = tstanje;
		sticiDo[1] = 1'b0;
		vrata = 0;
	end
	
	
	endcase
	
	tstanje = sstanje;
	end
	
	if(SW[0])begin
	tstanje = 3'b010;
	sstanje = 3'b0;
	sticiDo = 5'b0;
	end
	
end
endmodule