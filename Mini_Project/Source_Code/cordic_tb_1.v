`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2024 12:34:19
// Design Name: 
// Module Name: cordic_tb_1
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


module cordic_tb_1;
  reg  signed  [19:0] target_angle;
  reg clk,rst;
  wire signed [19:0] x_res;
  wire signed [19:0] y_res;
  cordic c(.target_angle(target_angle),.clk(clk),.rst(rst) , .x_res(x_res) , .y_res(y_res));
  
  // Always block to keep toggling the clock signal
  always #2 clk = ~clk;
  
  initial
     begin
       // here we define the target angle
       // 16 bits for the integer part and 4 bits for the fractional part of the target angle
       #0 clk = 1'b0; rst = 1'b0;
       #1 rst = 1'b1; 
       // In target_angle, we have 58.54 (16 bits for integer part and 4 bits for the fractional part)
       
       #5 target_angle = 20'b00000000001110101000;  // 58.54 degrees
       #5 target_angle = 20'b00000000000111110101;  // 31.33 degrees
       #5 target_angle = 20'b00000000010000110001;  // 67.12 degrees
       #5 target_angle = 20'b00000000000011001011;  // 12.689 degrees
       #5 target_angle = 20'b00000000000000000000;  // 0 degrees
       #5 target_angle = 20'b00000000010110100000;  // 90 degrees
       #20 $finish;
     end
endmodule
