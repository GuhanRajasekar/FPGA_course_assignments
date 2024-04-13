`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 18:37:23
// Design Name: 
// Module Name: cordic_sinh_cosh_testbench
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


module cordic_sinh_cosh_testbench;
  reg clk, rst;
  reg signed [19:0] target_angle; 
  
  wire signed[19:0] x_res, y_res;
  
  // target_angle => 10 bits for the integer part and 10 bits for the fractional part
  // x_res => 10 bits for the integer part and 10 bits for the fractional part
  // y_res => 10 bits for the integer part and 10 bits for the integer part
  
  cordic_sinh_cosh roger(.clk(clk), .rst(rst), .target_angle(target_angle), .x_res(x_res), .y_res(y_res));
  always #2 clk = ~clk;
  
  initial
    begin
       #0 clk = 1'b1; rst = 1'b0;
       #2 rst = 1'b1;
       #5 target_angle = {20'b00000000000110011001}; // target_angle = 0.4
       #5 target_angle = {20'b11111111111001100111}; // target_angle = -0.4
       #5 target_angle = {20'b00000000001001000111}; // target_angle = 0.57
       #5 target_angle = {20'b11111111110110111001}; // target_angle = -0.57
       
       #5 target_angle = {20'b00000000100000000000}; // target_angle = 2
       #5 target_angle = {20'b00000001010000000000}; // target_angle = 5
       
       #5 $finish;
    end
endmodule
