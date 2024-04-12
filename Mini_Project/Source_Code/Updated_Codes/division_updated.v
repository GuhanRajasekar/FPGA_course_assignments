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


module cordic_division(clk,rst,x_input,y_input,z_res);

// Apparently verilog does not support two dimensional arrays as ports (system verilog does)
// However, let us see if this works for simulation

 input clk,rst;  // Input clock and reset signals
 input signed [19:0] x_input;   // 20 bits to denote the x input(16 bits including MSB for the integer part and 4 bits for the fractional part)
 input signed [19:0] y_input;   // 20 bits to denote the y input (16 bits including MSB for the integer part and 4 bits for the fractional part)
 
 output reg signed [19:0] z_res; // 20 bits (4 for integer part and 16 for fractional part) 
 
 reg signed [19:0] x_input_clk ;  // to store the x input (4 bits for the integer part including MSB and 16 bits for the fractional part)
 reg signed [19:0] y_input_clk ;  // to store the y input (4 bits for the integer part including MSB and 16 bits for the fractional part)
 
 reg signed [19:0] x;        // to store the x results of each step (4 bits for the integer part including MSB and 16 bits for the fractional part)
 reg signed [19:0] y [9:0];  // to store the y results of each step (4 bits for the integer part including MSB and 16 bits for the fractional part)
 
 wire signed[19:0] look_up [9:0];       // to store look up values of arc tan using 20 bits (16 bits including MSB to denote the integer part and 4 bits to denote the fractional part)
 reg  signed[19:0] z[10:0];  // Array of 20 bit registers to store the rotated angle 
 reg  d[9:0]; // Array of 1 bit registers to denote the direction of rotation. 1/0 => Anticlockwise / Clockwise rotation 
 
  (*keep = "soft" *) reg d10;
 
 (*keep = "soft" *)reg signed [19:0] y10;
// parameter N = 10;  // Indicates the number of iterations
 
 // In the look up table of (2^-i), 10 bits are used for integer and 10 bits are used for fractional part
 assign look_up[0]  = 20'b00000000010000000000;   // 2 ^ (-0) = 1
 assign look_up[1]  = 20'b00000000001000000000;   // 2 ^ (-1) = 0.5
 assign look_up[2]  = 20'b00000000000100000000;   // 2 ^ (-2) = 0.25
 assign look_up[3]  = 20'b00000000000010000000;   // 2 ^ (-3) = 0.125
 assign look_up[4]  = 20'b00000000000001000000;   // 2 ^ (-4) = 0.0625
 assign look_up[5]  = 20'b00000000000000100000;   // 2 ^ (-5) = 0.03125
 assign look_up[6]  = 20'b00000000000000010000;   // 2 ^ (-6) = 0.015625
 assign look_up[7]  = 20'b00000000000000001000;   // 2 ^ (-7) = 0.0078125
 assign look_up[8]  = 20'b00000000000000000100;   // 2 ^ (-8) = 0.00390625
 assign look_up[9]  = 20'b00000000000000000010;   // 2 ^ (-9) = 0.001953125
// assign look_up[10] = 20'b00000000000000000001;   // 2 ^ (-10) = 0.0009765625
// assign look_up[11] = 20'b00000000000000100000;   // 2 ^ (-11) = 0.00048828125
// assign look_up[12] = 20'b00000000000000010000;   // 2 ^ (-12) = 0.000244140625
// assign look_up[13] = 20'b00000000000000001000;   // 2 ^ (-13) = 0.0001220703125
// assign look_up[14] = 20'b00000000000000000100;   // 2 ^ (-14) = 0.00006103515625
// assign look_up[15] = 20'b00000000000000000010;   // 2 ^ (-15) = 0.000030517578125
// assign look_up[16] = 20'b00000000000000000001;   // 2 ^ (-16) = 0.0000152587890625
 
 always@(posedge clk)
  begin
    if (rst == 0)
      begin
         x_input_clk     <= 20'b0;
         y_input_clk     <= 20'b0;
         z_res <= 20'b0; 
      end  
    else 
      begin
         x_input_clk <= x_input;
         y_input_clk <= y_input;
         z_res <= z[10][19:0]; 
      end
  end
 
 
 // Place them in a separate always block as they are fixed (This helps us avoid numerous RTL errors)
 always@(*)
   begin
      x    = x_input_clk; // x[0] = 0.6072 (4 bits for the integer part and 10 bits for the fractional part)
      y[0] = y_input_clk; // y[0] = 0.0000 (4 bits for the integer part and 10 bits for the fractional part)
      z[0] = 20'b0; 
      d[0] = ((x[19] ^ (y[0][19])) == 0) ? 0 : 1;  
   end
   
 integer i;
 always@(*)
   begin
      for(i = 1 ; i<= 9;i = i+1)
        begin
         y[i] = (d[i-1] == 1) ? (y[i-1] + (x>>>(i-1)) ) : (y[i-1]- (x>>>(i-1)) );
         z[i] = (d[i-1] == 1) ? (z[i-1] - look_up[i-1]) : (z[i-1]+look_up[i-1]);
         d[i] = ((x[19] ^ (y[i][19])) == 0) ? 0 : 1;
        end
        
         y10   = (d[9] == 1) ? (y[9] + (x>>>(9)) ) : (y[9]- (x>>>(9)) );
         z[10] = (d[9] == 1) ? (z[9] - look_up[9]) : (z[9]+look_up[9]);
         d10   = ((x[19] ^ (y10[19])) == 0) ? 0 : 1;
   end
endmodule
//step 1     
//     y[1] = (d[0] == 1) ? (y[0] + x) : (y[0]-x);
//     z[1] = (d[0] == 1) ? (z[0] - look_up[0]) : (z[0]+look_up[0]);
//     d[1] = ((x[19] ^ (y[1][19])) == 0) ? 0 : 1;
      
////step 2
//     y[2] = (d[1] == 1) ? (y[1] + (x>>>1)) : (y[1]-(x>>>1));
//     z[2] = (d[1] == 1) ? (z[1] - look_up[1]) : (z[1]+look_up[1]);
//     d[2] = ((x[19] ^ (y[2][19])) == 0) ? 0 : 1; 
     
////step 3
//     y[3] = (d[2] == 1) ? (y[2] + (x>>>2)) : (y[2]-(x>>>2));
//     z[3] = (d[2] == 1) ? (z[2] - look_up[2]) : (z[2]+look_up[2]);
//     d[3] = ((x[19] ^ (y[3][19])) == 0) ? 0 : 1;
     
////step 4
//     y[4] = (d[3] == 1) ? (y[3] + (x>>>3)) : (y[3]-(x>>>3));
//     z[4] = (d[3] == 1) ? (z[3] - look_up[3]) : (z[3]+look_up[3]);
//     d[4] = ((x[19] ^ (y[4][19])) == 0) ? 0 : 1;
     
////step 5
//     y[5] = (d[4] == 1) ? (y[4] + (x>>>4)) : (y[4]-(x[4]>>>4));
//     z[5] = (d[4] == 1) ? (z[4] - look_up[4]) : (z[4]+look_up[4]);
//     d[5] = ((x[19] ^ (y[5][19])) == 0) ? 0 : 1;
     
////step 6
//     y[6] = (d[5] == 1) ? (y[5] + (x>>>5)) : (y[5]-(x>>>5));
//     z[6] = (d[5] == 1) ? (z[5] - look_up[5]) : (z[5]+look_up[5]);
//     d[6] = ((x[19] ^ (y[6][19])) == 0) ? 0 : 1;
     
////step 7
//     y[7] = (d[6] == 1) ? (y[6] + (x>>>6)) : (y[6]-(x>>>6));
//     z[7] = (d[6] == 1) ? (z[6] - look_up[6]) : (z[6]+look_up[6]);
//     d[7] = ((x[19] ^ (y[7][19])) == 0) ? 0 : 1;
     
////step 8
//     y[8] = (d[7] == 1) ? (y[7] + (x>>>7)) : (y[7]-(x>>>7));
//     z[8] = (d[7] == 1) ? (z[7] - look_up[7]) : (z[7]+look_up[7]);
//     d[8] = ((x[19] ^ (y[8][19])) == 0) ? 0 : 1;
     
////step 9
//     y[9] = (d[8] == 1) ? (y[8] + (x>>>8)) : (y[8]-(x>>>8));
//     z[9] = (d[8] == 1) ? (z[8] - look_up[8]) : (z[8]+look_up[8]);
//     d[9] = ((x[19] ^ (y[9][19])) == 0) ? 0 : 1;

////step 10
//     y[10] = (d[9] == 1) ? (y[9] + (x>>>9)) : (y[9]-(x>>>9));
//     z[10] = (d[9] == 1) ? (z[9] - look_up[9]) : (z[9]+look_up[9]);
//     d[10] = ((x[19] ^ (y[10][19])) == 0) ? 0 : 1;


