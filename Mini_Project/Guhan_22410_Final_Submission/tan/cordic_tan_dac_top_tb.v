`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2024 23:04:35
// Design Name: 
// Module Name: cordic_tan_dac_top_tb
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


module cordic_tan_dac_top_tb;
  reg clk, rst;
  reg signed [12:0] slide_switch; 
  wire SCLK, SDATA1 , SDATA2, NSYNC;
  cordic_tan_dac_top test(.clk(clk) , .rst(rst), .slide_switch(slide_switch) , .SCLK(SCLK), .SDATA1(SDATA1), .SDATA2(SDATA2), .NSYNC(NSYNC));
  
  always #2 clk = ~clk;
  
  initial 
    begin
      #0 clk = 1'b1; rst = 1'b0;
      #2 rst = 1'b1; slide_switch = 20;
      
      #5000000 $finish;
    end
endmodule
