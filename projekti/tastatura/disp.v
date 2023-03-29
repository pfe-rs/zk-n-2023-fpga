module dispraw(
	/**
	 * The register containing raw bitmaps of characters.
	 */
	input [447:0] num,
	/**
	 * The offset in bits from which to extract the character bitmap, counting from the LSB.
	 */
	input [5:0] offset,
	/**
	 * The seven segment display to write the bitmap onto.
	 */
	output reg [6:0] disp
);
	// on `num` value change
	always @(num) begin
		// update current display with a 7 bit bitmap from `num`
		disp = { num[offset + 6], num[offset + 5], num[offset + 4],
			num[offset + 3], num[offset + 2], num[offset + 1], num[offset] };
	end
endmodule
