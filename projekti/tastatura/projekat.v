module projekat(
	input 		          		CLOCK_50,

	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	output		     [9:0]		LEDR,

	inout 		          		PS2_CLK,
	inout 		          		PS2_CLK2,
	inout 		          		PS2_DAT,
	inout 		          		PS2_DAT2
);

	/**
	 * Initialize the register for storing individual bitmaps of characters for the seven segment display.
	 * The size should be a multiple of 7 and greater than or equal to 42 (7 * 6; for at least 6 displays).
	 * Extending the size beyond 42 (7 * 6) allows a simple history mechanism to be implemented.
	 */
	wire [447:0] disp;
	/**
	 * The key state storage register.
	 * This program can recognize 124 different keyboard keys,
	 * hence the size of this register is 124 bits.
	 * Key indices are hardcoded, and may be seen in file:///./ps2.v
	 * A one (1) indicates the key is pressed and a zero (0) indicates it is not in fact, pressed.
	 */
	wire [123:0] keyreg;

	// initialize the annoying ps2 reader/parser thing
	ps2keyboard kb(PS2_CLK, PS2_DAT, disp, keyreg, LEDR);

	// listen for bitmap register changes, update displays accordingly
	dispraw(disp, 0, HEX0);
	dispraw(disp, 7, HEX1);
	dispraw(disp, 14, HEX2);
	dispraw(disp, 21, HEX3);
	dispraw(disp, 28, HEX4);
	dispraw(disp, 35, HEX5);
endmodule
