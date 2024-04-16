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


module cordic_tan_inverse_tb;
  reg  signed  [19:0] y_input;
  reg  clk, rst;
  
  wire signed [19:0] z_res;
  
  cordic_tan_inverse g(.clk(clk) , .rst(rst) , .y_input(y_input), .z_res(z_res));
  
  /* For x and y, have 4 bits for the fractional part and 16 bits for the integer part
     The look up table of tan inverse (2^-i) is initialized by using 16 bits for the integer part and 4 bits for the fractional part.
     Hence the result z_res must also be viewed in the same format */
  always #2 clk = ~clk;
 
  initial 
     begin
        #0 clk = 1'b0; rst = 1'b0; 
        #1 rst = 1'b1;
        #5 y_input = 20'b11111111111000100000;  // y = -30
        #5 y_input = 20'b11111111111000110000;  // y = -29
        #5 y_input = 20'b11111111111001000000;  // y = -28
        #5 y_input = 20'b11111111111001010000;  // y = -27
        #5 y_input = 20'b11111111111001100000;  // y = -26
        #5 y_input = 20'b11111111111001110000;  // y = -25
        #5 y_input = 20'b11111111111010000000;  // y = -24
        #5 y_input = 20'b11111111111010010000;  // y = -23
        #5 y_input = 20'b11111111111010100000;  // y = -22
        #5 y_input = 20'b11111111111010110000;  // y = -21
        #5 y_input = 20'b11111111111011000000;  // y = -20
        #5 y_input = 20'b11111111111011010000;  // y = -19
        #5 y_input = 20'b11111111111011100000;  // y = -18
        #5 y_input = 20'b11111111111011110000;  // y = -17
        #5 y_input = 20'b11111111111100000000;  // y = -16
        #5 y_input = 20'b11111111111100010000;  // y = -15
        #5 y_input = 20'b11111111111100100000;  // y = -14
        #5 y_input = 20'b11111111111100110000;  // y = -13
        #5 y_input = 20'b11111111111101000000;  // y = -12
        #5 y_input = 20'b11111111111101010000;  // y = -11
        #5 y_input = 20'b11111111111101100000;  // y = -10
        #5 y_input = 20'b11111111111101110000;  // y = -9
        #5 y_input = 20'b11111111111110000000;  // y = -8
        #5 y_input = 20'b11111111111110010000;  // y = -7
        #5 y_input = 20'b11111111111110100000;  // y = -6
        #5 y_input = 20'b11111111111110110000;  // y = -5
        #5 y_input = 20'b11111111111111000000;  // y = -4
        #5 y_input = 20'b11111111111111010000;  // y = -3
        #5 y_input = 20'b11111111111111100000;  // y = -2
        #5 y_input = 20'b11111111111111110000;  // y = -1
       
        #5 y_input = 20'b00000000000000000000;  // y = 0
        #5 y_input = 20'b00000000000000010000;  // y = 1
        #5 y_input = 20'b00000000000000100000;  // y = 2
        #5 y_input = 20'b00000000000000110000;  // y = 3
        #5 y_input = 20'b00000000000001000000;  // y = 4
        #5 y_input = 20'b00000000000001010000;  // y = 5
        #5 y_input = 20'b00000000000001100000;  // y = 6
        #5 y_input = 20'b00000000000001110000;  // y = 7
        #5 y_input = 20'b00000000000010000000;  // y = 8
        #5 y_input = 20'b00000000000010010000;  // y = 9
        #5 y_input = 20'b00000000000010100000;  // y = 10
        #5 y_input = 20'b00000000000010110000;  // y = 11
        #5 y_input = 20'b00000000000011000000;  // y = 12
        #5 y_input = 20'b00000000000011010000;  // y = 13
        #5 y_input = 20'b00000000000011100000;  // y = 14
        #5 y_input = 20'b00000000000011110000;  // y = 15
        #5 y_input = 20'b00000000000100000000;  // y = 16
        #5 y_input = 20'b00000000000100010000;  // y = 17
        #5 y_input = 20'b00000000000100100000;  // y = 18
        #5 y_input = 20'b00000000000100110000;  // y = 19
        #5 y_input = 20'b00000000000101000000;  // y = 20
        #5 y_input = 20'b00000000000101010000;  // y = 21
        #5 y_input = 20'b00000000000101100000;  // y = 22
        #5 y_input = 20'b00000000000101110000;  // y = 23
        #5 y_input = 20'b00000000000110000000;  // y = 24
        #5 y_input = 20'b00000000000110010000;  // y = 25
        #5 y_input = 20'b00000000000110100000;  // y = 26
        #5 y_input = 20'b00000000000110110000;  // y = 27
        #5 y_input = 20'b00000000000111000000;  // y = 28
        #5 y_input = 20'b00000000000111010000;  // y = 29
        #5 y_input = 20'b00000000000111100000;  // y = 30


//      for(i = -30; i<=30; i= i+1)
//        begin
//          #5 y_input = i;
//        end
      #15 $finish;
     end
 
endmodule
