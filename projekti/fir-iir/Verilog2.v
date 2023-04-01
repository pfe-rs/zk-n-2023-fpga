module filter(input clk, input rst, input [31:0] sin, output reg [31:0] sout);
	reg [31:0] sin_d [9:0];
	reg [31:0] sout_d [10:0];
	wire [31:0] a [11];
	assign a[0] = 32'd10000;
	assign a[1] = 32'd39765;
	assign a[2] = 32'd86759;
	assign a[3] = 32'd125876;
	assign a[4] = 32'd131927;
	assign a[5] = 32'd102782;
	assign a[6] = 32'd59798;
	assign a[7] = 32'd25504;
	assign a[8] = 32'd7605;
	assign a[9] = 32'd1429;
	assign a[10] = 32'd128;
	wire [31:0] b [11];
	assign b[0] = 32'd1133;
	assign b[1] = 32'd8558;
	assign b[2] = 32'd31228;
	assign b[3] = 32'd71963;
	assign b[4] = 32'd115533;
	assign b[5] = 32'd134742;
	assign b[6] = 32'd115533;
	assign b[7] = 32'd71963;
	assign b[8] = 32'd31228;
	assign b[9] = 32'd8558;
	assign b[10] = 32'd1133;

	always @(posedge clk) begin

		integer i = 0;
		sin_d[0] <= sin;
		for(i = 1; i < 10; i = i + 1) sin_d[i] <= sin_d[i - 1];
		sout = sin * b[0];
		for(i = 0; i < 10; i = i + 1) sout = sout + sin_d[i] * b[i + 1];
		for(i = 0; i < 11; i = i + 1) sout = sout - sout_d[i] * a[i];
		sout_d[0] <= sout;
		for(i = 1; i < 11; i = i + 1) sout_d[i] <= sout_d[i - 1];
	end
endmodule