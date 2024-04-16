`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2024 21:59:47
// Design Name: 
// Module Name: cordic_sin_cos_top_tb
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


module cordic_sin_cos_top_tb;
  reg clk, rst;
  reg signed [12:0] slide_switch; 
  wire SCLK, SDATA1 , SDATA2, NSYNC;
  cordic_sin_cos_top test(.clk(clk) , .rst(rst), .slide_switch(slide_switch) , .SCLK(SCLK), .SDATA1(SDATA1), .SDATA2(SDATA2), .NSYNC(NSYNC));
  
  always #2 clk = ~clk;
  
  initial 
    begin
      #0 clk = 1'b1; rst = 1'b0;
      #2 rst = 1'b1; slide_switch = 50;
      
      #5000000 $finish;
    end
endmodule
