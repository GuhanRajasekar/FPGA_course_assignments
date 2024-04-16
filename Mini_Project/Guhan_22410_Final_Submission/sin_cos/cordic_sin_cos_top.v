`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2024 21:35:14
// Design Name: 
// Module Name: cordic_sin_cos_top
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


module cordic_sin_cos_top(clk, rst, slide_switch, SCLK, SDATA1 , SDATA2, NSYNC);
input clk, rst;
input [12:0] slide_switch;

output SCLK, SDATA1 , SDATA2, NSYNC;

wire [11:0] x_res_wire_1;   // 12 bit wire to be driven by cosx value
wire [11:0] y_res_wire_1;   // 12 bit wire that will be driven by sinx value

wire [15:0] x_res_wire_2;
wire [15:0] y_res_wire_2;

cordic_sin_cos_dac fp(.slide_switch(slide_switch) , .clk(clk) ,.rst(rst),.x_res_seq(x_res_wire_1) , .y_res_seq(y_res_wire_1));

assign x_res_wire_2 = {4'b0000 , x_res_wire_1};   // 4 zeros padded at MSB to send to the DAC
assign y_res_wire_2 = {4'b0000 , y_res_wire_1};   // 4 zeros padded at MSB to send to the DAC

pmodDAC pmod(.clock100Mhz(clk) , .sine_data(y_res_wire_2), .cosine_data(x_res_wire_2), .rst(rst), .SCLK(SCLK) , .SDATA1(SDATA1), .SDATA2(SDATA2) , .NSYNC(NSYNC));



endmodule
