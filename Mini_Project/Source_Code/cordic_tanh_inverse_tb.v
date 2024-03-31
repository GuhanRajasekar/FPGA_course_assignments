`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2024 12:50:29
// Design Name: 
// Module Name: cordic_tanh_inverse_tb
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


module cordic_tanh_inverse_tb;
  reg  signed  [19:0] y_input;
  reg  clk, rst;
  
  wire signed [19:0] z_res;
  
  cordic_tanh_inverse k(.clk(clk) , .rst(rst), .y_input(y_input), .z_res(z_res));
  
  always #2 clk = ~clk;
  
  /*
    In tanh inverse the valid input values are (-1,1).
    So for the input values , we use 4 bits for the integer part and the 16 bits for the fractional part
    For the result, we use 6 bits for the integer part and 14 bits for the fractional part
  */
  initial 
     begin
      #0 clk = 1'b0; rst = 1'b0; 
      #1 rst = 1'b1;
      #5 y_input = {{4'b0000},{16'b0111011110001101}} ; // y = 0.467
      #5 y_input = {{4'b1111},{16'b1000100001110011}} ; // y = -0.467
      #5 y_input = {{4'b0000},{16'b1111111110111110}} ; // y = 0.999
      #5 y_input = {{4'b1111},{16'b0000000001000010}} ; // y = 0.999
      #5 y_input = {{4'b0000},{16'b1110011001100110}} ; // y = 0.9
      #5 y_input = {{4'b0000},{16'b1100110011001100}} ; // y = 0.79998779296875
      #5 y_input = {{4'b0000},{16'b1111111100110011}} ; // y = 0.996871
      #15 $finish;
     end
endmodule
