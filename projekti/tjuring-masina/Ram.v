module RAM (
	clock,
	data,
	rdaddress,
	wraddress,
	wren,
	q);

	input	  clock;
	input	[7:0]  data;
	input	[6:0]  rdaddress;
	input	[6:0]  wraddress;
	input	  wren;
	output	[7:0]  q;
	
	reg[7:0] mem [127:0];
	always @(posedge clock) begin
		
	end
endmodule