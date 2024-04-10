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
      #5 y_input = {{4'b1111},{16'b0000110011001101}} ; // y = -0.9
      #5 y_input = {{4'b1111},{16'b0001100110011010}} ; // y = -0.9
      #5 y_input = {{4'b1111},{16'b0010011001100111}} ; // y = -0.85
      #5 y_input = {{4'b1111},{16'b0011001100110100}} ; // y = -0.8
      #5 y_input = {{4'b1111},{16'b0100000000000000}} ; // y = -0.75
      #5 y_input = {{4'b1111},{16'b0100110011001101}} ; // y = -0.7
      #5 y_input = {{4'b1111},{16'b0101100110011010}} ; // y = -0.65
      #5 y_input = {{4'b1111},{16'b0110011001100111}} ; // y = -0.6
      #5 y_input = {{4'b1111},{16'b0111001100110100}} ; // y = -0.55
      #5 y_input = {{4'b1111},{16'b1000000000000000}} ; // y = -0.5
      #5 y_input = {{4'b1111},{16'b1000110011001101}} ; // y = -0.45
      #5 y_input = {{4'b1111},{16'b1001100110011010}} ; // y = -0.4
      #5 y_input = {{4'b1111},{16'b1010011001100111}} ; // y = -0.35
      #5 y_input = {{4'b1111},{16'b1011001100110100}} ; // y = -0.3
      #5 y_input = {{4'b1111},{16'b1100000000000000}} ; // y = -0.25
      #5 y_input = {{4'b1111},{16'b1100110011001101}} ; // y = -0.2
      #5 y_input = {{4'b1111},{16'b1101100110011010}} ; // y = -0.15
      #5 y_input = {{4'b1111},{16'b1110011001100111}} ; // y = -0.1
      #5 y_input = {{4'b1111},{16'b1111001100110100}} ; // y = -0.05
     
      #5 y_input = {{4'b0000},{16'b0000000000000000}} ; // y = 0
      #5 y_input = {{4'b0000},{16'b0000110011001100}} ; // y = 0.05
      #5 y_input = {{4'b0000},{16'b0001100110011001}} ; // y = 0.1
      #5 y_input = {{4'b0000},{16'b0010011001100110}} ; // y = 0.15
      #5 y_input = {{4'b0000},{16'b0011001100110011}} ; // y = 0.2
      #5 y_input = {{4'b0000},{16'b0100000000000000}} ; // y = 0.25
      #5 y_input = {{4'b0000},{16'b0100110011001100}} ; // y = 0.3
      #5 y_input = {{4'b0000},{16'b0101100110011001}} ; // y = 0.35
      #5 y_input = {{4'b0000},{16'b0110011001100110}} ; // y = 0.4
      #5 y_input = {{4'b0000},{16'b0111001100110011}} ; // y = 0.45
      #5 y_input = {{4'b0000},{16'b1000000000000000}} ; // y = 0.5
      #5 y_input = {{4'b0000},{16'b1000110011001100}} ; // y = 0.55
      #5 y_input = {{4'b0000},{16'b1001100110011001}} ; // y = 0.6
      #5 y_input = {{4'b0000},{16'b1010011001100110}} ; // y = 0.65
      #5 y_input = {{4'b0000},{16'b1011001100110011}} ; // y = 0.7
      #5 y_input = {{4'b0000},{16'b1100000000000000}} ; // y = 0.75
      #5 y_input = {{4'b0000},{16'b1100110011001100}} ; // y = 0.8
      #5 y_input = {{4'b0000},{16'b1101100110011001}} ; // y = 0.85
      #5 y_input = {{4'b0000},{16'b1110011001100110}} ; // y = 0.9
      #5 y_input = {{4'b0000},{16'b1111001100110011}} ; // y = 0.95
      #15 $finish;
     end
endmodule