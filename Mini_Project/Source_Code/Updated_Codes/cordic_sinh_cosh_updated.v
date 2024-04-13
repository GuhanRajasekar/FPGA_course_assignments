`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2024 11:36:05
// Design Name: 
// Module Name: cordic_sin_cos
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


module cordic_sinh_cosh(clk,rst,target_angle,x_res,y_res);

// Apparently verilog does not support two dimensional arrays as ports (system verilog does)
// However, let us see if this works for simulation

 input clk,rst;  // Input clock and reset signals
 input signed [19:0] target_angle;   // 20 bits to denote the target angle of rotation (10 bits including MSB for the integer part and 10 bits for the fractional part)
 
 
 output reg signed [19:0] x_res; // 20 bits (10 for integer part and 10 for fractional part) to store the x-coordinate of the final rotated vector
 output reg signed [19:0] y_res; // 20 bits (10 for integer part and 10 for fractional part) to store the y-coordinate of the final rotated vector
// output reg [31:0] final_rotation_angle; // dummy output register to overcome RTL error 
 
// wire signed [19:0] x_res_comb; // 20 bits (4 for integer part and 16 for fractional part) to store the x-coordinate of the final rotated vector
// wire signed [19:0] y_res_comb; // 20 bits (4 for integer part and 16 for fractional part) to store the y-coordinate of the final rotated vector
 
 reg signed [19:0] x [9:1];  // to store the x-coordinates of each step (4 bits for the integer part including MSB and 16 bits for the fractional part)
 reg signed [19:0] y [9:1];  // to store the y-coordinates of each step (4 bits for the integer part including MSB and 16 bits for the fractional part)
 
 wire signed[19:0] look_up [8:1];       // to store look up values of arc tan using 20 bits (16 bits including MSB to denote the integer part and 4 bits to denote the fractional part)
 reg  signed[19:0] z[8:1];  // Array of 20 bit registers to store the rotated angle 
 reg  d[8:1]; // Array of 1 bit registers to denote the direction of rotation. 1/0 => Anticlockwise / Clockwise rotation 

 
 
 reg signed [19:0] x4; // Used to store the x result when the 4th iteration is repeated
 reg signed [19:0] y4; // Used to store the y result when the 4th iteration is repeated
 reg signed [19:0] z4; // Used to store the z result when the 4th iteration is repeated
 reg d4;  

 // In the look up table of tanh inverse (2^-i), 10 bits are used for the integer part and 10 bits for the fractional part
 assign look_up[1] = {{10{1'b0}},{10'b1000110010}};   // tanh inverse(2^-1) = 0.5493
 assign look_up[2] = {{10{1'b0}},{10'b0100000101}};   // tanh inverse(2^-2) = 0.2554
 assign look_up[3] = {{10{1'b0}},{10'b0010000000}};   // tanh inverse(2^-3) = 0.1256
 assign look_up[4] = {{10{1'b0}},{10'b0001000000}};   // tanh inverse(2^-4) = 0.0625
 assign look_up[5] = {{10{1'b0}},{10'b0000100000}};   // tanh inverse(2^-5) = 0.0312
 assign look_up[6] = {{10{1'b0}},{10'b0000010000}};   // tanh inverse(2^-6) = 0.0156
 assign look_up[7] = {{10{1'b0}},{10'b0000001000}};   // tanh inverse(2^-7) = 0.0078
 assign look_up[8] = {{10{1'b0}},{10'b0000000100}};   // tanh inverse(2^-8) = 0.0039

 always@(posedge clk , negedge rst)   // Asynchronous Reset
  begin
    if (rst == 0)
       begin
         x_res [19:0]     <= 20'b0;
         y_res [19:0]     <= 20'b0;  
       end 
    else 
       begin
         x_res [19:0] <= x[9][19:0];
         y_res [19:0] <= y[9][19:0];
       end
  end

 // Place them in a separate always block as they are fixed (This helps us avoid numerous RTL errors)
 always@(*)
   begin
      x[1] = 20'b00000000010011010100; // x[1] = 1.2075 (10 bits for the integer part and 10 bits for the fractional part)
      y[1] = 20'b00000000000000000000; // y[1] = 0.0000 (10 bits for the integer part and 10 bits for the fractional part)
      z[1] = target_angle; // First we always rotate by 0 degrees => Update the rotated angle accordingly
      d[1] = (z[1][19] == 0) ? 1 : 0;
   end
   
   
 always@(*)
   begin

//step 2
     x[2] = (d[1] == 1) ? (x[1] + (y[1]>>>1)) : (x[1]-(y[1]>>>1));
     y[2] = (d[1] == 1) ? (y[1] + (x[1]>>>1)) : (y[1]-(x[1]>>>1));
     z[2] = (d[1] == 1) ? (z[1] - look_up[1]) : (z[1]+look_up[1]);
     d[2] = (z[2][19] == 0) ? 1 : 0;   
     
//step 3
     x[3] = (d[2] == 1) ? (x[2] + (y[2]>>>2)) : (x[2]-(y[2]>>>2));
     y[3] = (d[2] == 1) ? (y[2] + (x[2]>>>2)) : (y[2]-(x[2]>>>2));
     z[3] = (d[2] == 1) ? (z[2] - look_up[2]) : (z[2]+look_up[2]);
     d[3] = (z[3][19] == 0) ? 1 : 0; 
     
//step 4
     x[4] = (d[3] == 1) ? (x[3] + (y[3]>>>3)) : (x[3]-(y[3]>>>3));
     y[4] = (d[3] == 1) ? (y[3] + (x[3]>>>3)) : (y[3]-(x[3]>>>3));
     z[4] = (d[3] == 1) ? (z[3] - look_up[3]) : (z[3]+look_up[3]);
     d[4] = (z[4][19] == 0) ? 1 : 0; 

// step 4_prime (Repeat of iteration 4 for convergence purposes)
     x4 = (d[4] == 1) ? (x[4] + (y[4]>>>3)) : (x[4]-(y[4]>>>3));
     y4 = (d[4] == 1) ? (y[4] + (x[4]>>>3)) : (y[4]-(x[4]>>>3));
     z4 = (d[4] == 1) ? (z[4] - look_up[3]) : (z[4]+look_up[3]);
     d4 = (z4[19] == 0) ? 0 : 1;
         
//step 5
     x[5] = (d4 == 1) ? (x4 + (y4>>>4)) : (x4-(y4>>>4));
     y[5] = (d4 == 1) ? (y4 + (x4>>>4)) : (y4-(x4>>>4));
     z[5] = (d4 == 1) ? (z4 - look_up[4]) : (z4+look_up[4]);
     d[5] = (z[5][19] == 0) ? 1 : 0; 
     
//step 6
     x[6] = (d[5] == 1) ? (x[5] + (y[5]>>>5)) : (x[5]-(y[5]>>>5));
     y[6] = (d[5] == 1) ? (y[5] + (x[5]>>>5)) : (y[5]-(x[5]>>>5));
     z[6] = (d[5] == 1) ? (z[5] - look_up[5]) : (z[5]+look_up[5]);
     d[6] = (z[6][19] == 0) ? 1 : 0; 
     
//step 7
     x[7] = (d[6] == 1) ? (x[6] + (y[6]>>>6)) : (x[6]-(y[6]>>>6));
     y[7] = (d[6] == 1) ? (y[6] + (x[6]>>>6)) : (y[6]-(x[6]>>>6));
     z[7] = (d[6] == 1) ? (z[6] - look_up[6]) : (z[6]+look_up[6]);
     d[7] = (z[7][19] == 0) ? 1 : 0; 
     
//step 8
     x[8] = (d[7] == 1) ? (x[7] + (y[7]>>>7)) : (x[7]-(y[7]>>>7));
     y[8] = (d[7] == 1) ? (y[7] + (x[7]>>>7)) : (y[7]-(x[7]>>>7));
     z[8] = (d[7] == 1) ? (z[7] - look_up[7]) : (z[7]+look_up[7]);
     d[8] = (z[8][19] == 0) ? 1 : 0; 
     
//step 9
     x[9] = (d[8] == 1) ? (x[8] + (y[8]>>>8)) : (x[8]-(y[8]>>>8));
     y[9] = (d[8] == 1) ? (y[8] + (x[8]>>>8)) : (y[8]-(x[8]>>>8));
     z[9] = (d[8] == 1) ? (z[8] - look_up[8]) : (z[8]+look_up[8]);
     d[9] = (z[9][19] == 0) ? 1 : 0; 
   end

endmodule