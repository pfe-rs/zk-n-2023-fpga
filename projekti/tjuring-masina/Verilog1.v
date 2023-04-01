module clkdiv(input clk, output reg clkout);
reg[22:0] brojac = 0;
always@(posedge clk) begin
brojac = brojac + 1;
//if(brojac>=162) begin
if(brojac>=2000000)begin
clkout = ~clkout;
brojac = 0;
end
end
endmodule