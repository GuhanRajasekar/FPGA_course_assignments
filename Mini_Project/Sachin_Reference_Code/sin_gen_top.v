`timescale 1ns / 1ps


module sin_gen_top(
input clk, rst,
input [10:0] freq_reg,
output cs, data, sclk
    );
    
 reg [11:0] angle_in,dac_in;
 wire [11:0] sin_out;
 reg start_dac,clk_slow;
 wire clk_10;
 integer count; 
    
 sincos_pipelined sincomp(.Clock(clk_slow),.Reset(rst),.Angle(angle_in),.Sin(sin_out),.Cos());   
 clk_wiz_0 clkinst(.clk_out1(clk_10),.clk_in1(clk));   

 // sclk is nothing but clk_10
 spi_dac spiinst(.clk_in(clk_10),.rst(rst),.datain(dac_in),.start(clk_slow),.data(data),.cs(cs),.sclk(sclk));   
 
always@(posedge clk_10)
begin

if (rst) begin
angle_in <= 12'h000;
clk_slow <= 1'b0;
count <= 0;
end
else begin
count <= count +1;
if (count>8) begin
count <=0;
clk_slow <= ~ clk_slow;
if (clk_slow) begin
angle_in <= angle_in + {$signed(1'b0), freq_reg} + 1'b1;
dac_in <= $unsigned(sin_out + 12'h800);
end
end
end
end  
    
    
endmodule
