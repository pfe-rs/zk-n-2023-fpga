module CTRL (input [7:0] din, input reset, input vin, output r, input clk, output [7:0] dout, output wren, output reg[6:0] adr);
assign r = 1;
assign dout = din;
assign wren = vin;
always @(posedge clk) begin
if(!reset) adr = 0;
else if(vin && adr < 127) begin
adr = adr+1;
end
end
endmodule