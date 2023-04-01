module Matrix_interface(input clk, output reg [71:0] A, output reg [71:0] B, input [71:0] C);

reg [4:0] cnt;
reg [7:0] din;
wire [7:0] dout;
reg wren;

Matrix_input mi(
	cnt,
	clk,
	din,
	wren,
	dout);

always @(posedge clk) begin

	cnt<=cnt+1;
	
	case(cnt)
	5'd2: begin A[ 7: 0] <= dout; end
	5'd3: begin A[15: 8] <= dout; end
	5'd4: begin A[23:16] <= dout; end
	5'd5: begin A[31:24] <= dout; end
	5'd6: begin A[39:32] <= dout; end
	5'd7: begin A[47:40] <= dout; end
	5'd8: begin A[55:48] <= dout; end
	5'd9: begin A[63:56] <= dout; end
	5'd10: begin A[71:64] <= dout; end
	5'd11: begin B[ 7: 0] <= dout; end
	5'd12: begin B[15: 8] <= dout; end
	5'd13: begin B[23:16] <= dout; end
	5'd14: begin B[31:24] <= dout; end
	5'd15: begin B[39:32] <= dout; end
	5'd16: begin B[47:40] <= dout; end
	5'd17: begin B[55:48] <= dout; end
	5'd18: begin B[63:56] <= dout; end
	5'd19: begin B[71:64] <= dout; din <= C[7:0]; wren <= 1'b1; end
	5'd20: begin din <= C[15: 8]; wren <= 1'b1; end
	5'd21: begin din <= C[23:16]; wren <= 1'b1; end
	5'd22: begin din <= C[31:24]; wren <= 1'b1; end
	5'd23: begin din <= C[39:32]; wren <= 1'b1; end
	5'd24: begin din <= C[47:40]; wren <= 1'b1; end
	5'd25: begin din <= C[55:48]; wren <= 1'b1; end
	5'd26: begin din <= C[63:56]; wren <= 1'b1; end
	5'd27: begin din <= C[71:64]; wren <= 1'b1; end
	5'd28: begin wren <= 1'b0; end
	endcase

end

endmodule