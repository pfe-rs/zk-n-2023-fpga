module clkdiv(input clk, output reg clkout);
	reg [31:0]brojac;
	always @(posedge clk)begin
		brojac = brojac + 1;
		if(brojac == 162) begin
			clkout = !clkout;
			brojac = 0;
		end
	end
endmodule