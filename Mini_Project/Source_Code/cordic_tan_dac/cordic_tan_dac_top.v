`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2024 22:52:57
// Design Name: 
// Module Name: cordic_tan_dac_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cordic_tan_dac_top(clk,rst,slide_switch,SCLK,SDATA1,SDATA2,NSYNC);
input clk, rst;
input [12:0] slide_switch;

output SCLK, SDATA1 , SDATA2, NSYNC;

wire [11:0] tan;   // 12 bit wire to be driven by cosx value
wire [11:0] cos;   // 12 bit wire that will be driven by sinx value
(*keep = "soft"*) wire [11:0] sin;

wire [15:0] tan2;
wire [15:0] cos2;

cordic_tan_dac ecsd(.slide_switch(slide_switch) , .clk(clk) ,.rst(rst),.tan(tan), .sin(sin) , .cos(cos));

assign tan2 = {4'b0000 , tan};   // 4 zeros padded at MSB to send to the DAC
assign cos2 = {4'b0000 , cos};   // 4 zeros padded at MSB to send to the DAC

pmodDAC pmod(.clock100Mhz(clk) , .sine_data(tan2), .cosine_data(cos2), .rst(rst), .SCLK(SCLK) , .SDATA1(SDATA1), .SDATA2(SDATA2) , .NSYNC(NSYNC));


endmodule
