module one_sec(input cl, output reg [32:0] s);
	reg [32:0] counter;

	always @(posedge cl) begin
		if (counter > 33'd3_000_000) begin
			counter = 33'd0;
			s = s + 1;
		end
		else
			counter = counter + 1;
	end
endmodule
