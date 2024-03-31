`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2024 23:39:33
// Design Name: 
// Module Name: cordic_sinh_cosh_tb
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


module cordic_sinh_cosh_tb;
  reg  signed  [31:0] target_angle;
  reg clk,rst;
  wire signed [31:0] x_res;
  wire signed [31:0] y_res;
  
  cordic_sinh_cosh w(.clk(clk),.rst(rst),.target_angle(target_angle), .x_res(x_res) , .y_res(y_res));
  
  always #2 clk = ~clk;
  
  /*
     for target angle the precision is 16 bits for integer part and 16 bits for the fractional part(Based on the look up table used)
     For the results, the precision is 16 bits for integer part and 16 bits for the fractional part
  */
  initial 
     begin
      #0 clk = 1'b0; rst = 1'b0; 
      #1 rst = 1'b1;
      #5 target_angle = 32'b00000000000000001000100011110101; // 0.535
      #5 target_angle = 32'b11111111111111110111011100001011; // -0.535 (2's complement of 0.535)
      #5 target_angle = {{14{1'b0}},2'b10,{16{1'b0}}}; // 2
      #5 target_angle = {{16{1'b0}},16'b1100110011001100}; //0.8
      #15 $finish;
     end
endmodule
