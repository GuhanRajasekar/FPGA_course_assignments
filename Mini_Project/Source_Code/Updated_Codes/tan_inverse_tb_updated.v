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
  
  /* x is initialized with 1 by using 16 bits for integer part and 4 bits for the fractional part.
     Hence y also needs to be given in the same format (16 bits for the integer part and 4 bits for the fractional part).
     The look up table of tan inverse (2^-i) is initialized by using 16 bits for the integer part and 4 bits for the fractional part.
     Hence the result z_res must also be viewed in the same format */
  always #2 clk = ~clk;
  
  integer i;
  initial 
     begin
      #0 clk = 1'b0; rst = 1'b0; 
      #1 rst = 1'b1;
//      #5 y_input = 20'b00000001011011010000; // y =  365
//      #5 y_input = 20'b11111110100100110000; // y = -365
//      #5 y_input = 20'b00000000000110000000; // y = 24
//      #5 y_input = 20'b11111111111010000000; // y = -24
//      #5 y_input = 20'b00000000000000000000; // y =  0
//      #5 y_input = 20'b00000000000000110000; // y =  3  
//      #5 y_input = 20'b11111111111111010000; // y =  3  
//      #5 y_input = 20'b00000000001101101000; // y = 54.5
//      #5 y_input = 20'b11111111110010011000; // y = -54.5
//      #5 y_input = 20'b00000000000000000001; // y = 0.0625
//      #5 y_input = 20'b11111111111111111111; // y = -0.0625 (2's complement of 0.0625)
//      #5 y_input = 20'b00000000000011000000; // y = 12
//      #5 y_input = 20'b11111111111101000000; // y = -12
//      #5 y_input = 20'b00000000000000001000; // y = 0.5
//      #5 y_input = 20'b11111111111111111000; // y = -0.5

      for(i = -100; i<=100; i= i+1)
        begin
          #5 y_input = i;
        end
      #15 $finish;
     end
 
endmodule
