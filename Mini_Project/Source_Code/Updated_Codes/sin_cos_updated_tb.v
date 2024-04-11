`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2024 13:15:57
// Design Name: 
// Module Name: cordic_sin_cos_dac_tb
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


module cordic_sin_cos_dac_tb;
  reg clk, rst;
  reg  signed [12:0] slide_switch; // MSB switch must always be held low
  wire signed [11:0] x_res_seq, y_res_seq;
  
  cordic_sin_cos_dac nole(.clk(clk), .rst(rst), .slide_switch(slide_switch), .x_res_seq(x_res_seq),.y_res_seq(y_res_seq));
  
  always #2 clk = ~clk;
  initial 
    begin
      #0 clk = 1; rst = 1'b0; 
      #1 rst = 1'b1; slide_switch = 13'd20;
      
      #500000000 $finish;
    end
  
endmodule
