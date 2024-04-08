`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2024 15:32:01
// Design Name: 
// Module Name: cordic_divsion_tb
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


module cordic_divsion_tb;
  reg  signed  [19:0] x_input;
  reg  signed  [19:0] y_input;
  reg  clk, rst;
  
  wire signed [19:0] z_res;
  
  cordic_division m(.clk(clk) , .rst(rst) , .x_input(x_input), .y_input(y_input), .z_res(z_res));
  
  always #2 clk = ~clk;
  
  initial 
     begin
      #0 clk = 1'b0; rst = 1'b0; 
      #1 rst = 1'b1;
      #5 x_input = 20'b00000000000000010000 ; y_input = 20'b11111111111111110000 ; 
      #15 $finish;
     end
 
endmodule
