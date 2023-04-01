module CTRL2 (input [7:0] din, input reset, input dugme, input clk, output [7:0] dout, output reg [6:0] adresa, input posalji, output reg wren);
assign dout = din;
//reg kontrola = 0;
always @(posedge clk) begin
if(!reset)adresa=0;
else begin;
if(dugme) begin //kontrola=1; if(kontrola) begin
if (adresa < 127) wren = 1; else wren = 0;
if(adresa < 127 && posalji) adresa = adresa + 1;
end
else wren = 0;
end
//else kontrola = 0;
end
endmodule