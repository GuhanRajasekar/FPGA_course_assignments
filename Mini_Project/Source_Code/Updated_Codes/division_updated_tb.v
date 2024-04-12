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
//      #5 x_input = 20'b00000000000000010000 ; y_input = 20'b11111111111111110000 ; // x = 1, y = -1
      #5 x_input = {{6{1'b0}},4'b0010,{10{1'b0}}}; y_input = {{6{1'b0}},4'b0011,{10{1'b0}}} ; // x = 2, y =  3
      #5 x_input = {{6{1'b0}},4'b0100,{10{1'b0}}}; y_input = {{6{1'b0}},4'b0001,{10{1'b0}}} ; // x = 4, y =  1
      #5 x_input = {{6{1'b0}},4'b0001,{10{1'b0}}}; y_input = {{6{1'b0}},4'b0101,{10{1'b0}}} ; // x = 1, y =  5
      #5 x_input = {{6{1'b0}},4'b0111,{10{1'b0}}}; y_input = {{6{1'b0}},4'b0101,{10{1'b0}}} ; // x = 7, y =  5
      #5 x_input = {{6{1'b0}},4'b1000,{10{1'b0}}}; y_input = {{6{1'b0}},4'b0101,{10{1'b0}}} ; // x = 8, y =  5
      #5 x_input = {{6{1'b0}},4'b0110,{10{1'b0}}}; y_input = {{6{1'b0}},4'b0010,{10{1'b0}}} ; // x = 6, y =  2
      #5 x_input = {{6{1'b1}},4'b1000,{10{1'b0}}}; y_input = {{6{1'b0}},4'b0111,{10{1'b0}}} ; // x = -8, y =  7
//      #5 x_input = {{6{1'b0}},4'b0100,{10{1'b0}}}; x_input = {{6{1'b0}},4'b001,{10{1'b0}}} ;
//      #5 x_input = 20'b00000000000000010000 ; y_input = 20'b00000000000000100000 ; // x = 1, y =  2
//      #5 x_input = 20'b00000000000001110000 ; y_input = 20'b00000000000000110000 ; // x = 7, y =  3
//      #5 x_input = 20'b00000000000000110000 ; y_input = 20'b00000000000001110000 ; // x = 3, y = 7
//      #5 x_input = 20'b00000000000001100000 ; y_input = 20'b00000000000000010000 ; // x = 6, y = 1
//      #5 x_input = 20'b00000000000010000000 ; y_input = 20'b00000000000000110000 ; // x = 6, y = 1
      #15 $finish;
     end
 
endmodule
