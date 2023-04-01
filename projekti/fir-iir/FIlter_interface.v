module Filter_interface(input clk, input synR, output [31:0] outSample, input [31:0] inSample);

reg [11:0] cnt;
reg run;
wire [31:0] q;

Sample_RAM inputRAM(cnt, clk, 32'd0, 1'b0, outSample);
	
Sample_RAM outputRAM(cnt, clk, inSample, run, q);

always @(posedge clk) begin
	if(!run && synR) begin
		run <= 1'b1;
		cnt <= 0;
	end
	else if(run) begin
		cnt <= cnt + 1;
		if(cnt == 12'd4095) begin
			run <= 1'b0;
		end
	end
end

endmodule