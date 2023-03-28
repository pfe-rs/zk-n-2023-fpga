module CLKDIV #(parameter count_num = 162) (input clk, output reg out);

integer cnt = 0;

always @(posedge clk) begin
	cnt = cnt + 1;
	if(cnt == count_num)
	begin
		out = !out;
		cnt = 0;
	end
end

endmodule