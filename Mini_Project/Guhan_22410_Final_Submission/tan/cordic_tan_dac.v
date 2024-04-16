`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2024 20:13:51
// Design Name: 
// Module Name: cordic_tan_dac
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


module cordic_tan_dac(slide_switch , clk, rst , tan , sin, cos);
 input clk,rst;
 input signed [12:0] slide_switch; 
 
// output  [11:0] tan,sin,cos;   // output quantities
 
// output signed [11:0] tan, sin , cos;
 output  [11:0] tan, sin , cos;
// wire [11:0] tan1;
 
 wire [11:0]tan1, sin1,cos1;
 
// wire signed [11:0] x_res_seq, y_res_seq;
 
 
 cordic_sin_cos_dac   fpga1(.slide_switch(slide_switch), .clk(clk), .rst(rst), .x_res_seq(cos1), .y_res_seq(sin1));
 cordic_division_tan  fpga2(.clk(clk) , .rst(rst) , .x_input(cos1) , .y_input(sin1) , .z_res(tan1));
 
//  Adding an offset to send values to the DAC
 assign sin = $unsigned(cos1 + 12'h400);
 assign cos = $unsigned(sin1 + 12'h400);
 assign tan = $unsigned(tan1 + 12'h400);

//  assign sin = sin1; // 2 bits for the integer part and 4 bits for the fractional part
//  assign cos = cos1; // 2 bits for the integer part and 4 bits for the fractional part
//  assign tan = tan1; // 2 bits for the integer part and 4 bits for the fractional part
 
endmodule
