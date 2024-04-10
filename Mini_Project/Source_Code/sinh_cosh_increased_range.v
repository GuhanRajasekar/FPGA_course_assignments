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
 input signed [31:0] target_angle;   // 20 bits to denote the target angle of rotation (16 bits including MSB for the integer part and 4 bits for the fractional part)
 
 
 output reg signed [31:0] x_res; // 20 bits (4 for integer part and 16 for fractional part) to store the x-coordinate of the final rotated vector
 output reg signed [31:0] y_res; // 20 bits (4 for integer part and 16 for fractional part) to store the y-coordinate of the final rotated vector
// output reg [31:0] final_rotation_angle; // dummy output register to overcome RTL error 
 
 wire signed [31:0] x_res_comb; // 20 bits (4 for integer part and 16 for fractional part) to store the x-coordinate of the final rotated vector
 wire signed [31:0] y_res_comb; // 20 bits (4 for integer part and 16 for fractional part) to store the y-coordinate of the final rotated vector
 
 reg signed [31:0] x [27:1];  // to store the x-coordinates of each step (4 bits for the integer part including MSB and 16 bits for the fractional part)
 reg signed [31:0] y [27:1];  // to store the y-coordinates of each step (4 bits for the integer part including MSB and 16 bits for the fractional part)
 
 wire signed[31:0] look_up [27:1];       // to store look up values of arc tan using 20 bits (16 bits including MSB to denote the integer part and 4 bits to denote the fractional part)
 reg  signed[31:0] z[27:1];  // Array of 20 bit registers to store the rotated angle 
 reg  d[27:1]; // Array of 1 bit registers to denote the direction of rotation. 1/0 => Anticlockwise / Clockwise rotation 

 
 
 reg signed [31:0] x4; // Used to store the x result when the 4th iteration is repeated
 reg signed [31:0] y4; // Used to store the y result when the 4th iteration is repeated
 reg signed [31:0] z4; // Used to store the z result when the 4th iteration is repeated
 reg d4;  
 
 reg signed [31:0] x13; // Used to store the x result when the 13th iteration is repeated
 reg signed [31:0] y13; // Used to store the y result when the 13th iteration is repeated
 reg signed [31:0] z13; // Used to store the z result when the 13th iteration is repeated
 reg d13;  
 
 // In the look up table of tanh inverse (2^-i), 5 bits are used for the integer part and 27 bits for the fractional part
 assign look_up[1]  = {{5{1'b0}},{16'b1000110010011100},{11{1'b0}}};   // tanh inverse(2^-1) = 0.5493
 assign look_up[2]  = {{5{1'b0}},{16'b0100000101100000},{11{1'b0}}};   // tanh inverse(2^-2) = 0.2554
 assign look_up[3]  = {{5{1'b0}},{16'b0010000000100100},{11{1'b0}}};   // tanh inverse(2^-3) = 0.1256
 assign look_up[4]  = {{5{1'b0}},{16'b0001000000000000},{11{1'b0}}};   // tanh inverse(2^-4) = 0.0625
 assign look_up[5]  = {{5{1'b0}},{16'b0000011111111100},{11{1'b0}}};   // tanh inverse(2^-5) = 0.0312
 assign look_up[6]  = {{5{1'b0}},{16'b0000001111111100},{11{1'b0}}};   // tanh inverse(2^-6) = 0.0156
 assign look_up[7]  = {{5{1'b0}},{16'b0000000111111100},{11{1'b0}}};   // tanh inverse(2^-7) = 0.0078
 assign look_up[8]  = {{5{1'b0}},{16'b0000000011111100},{11{1'b0}}};   // tanh inverse(2^-8) = 0.0039
 assign look_up[9]  = {{5{1'b0}},{16'b0000000010000000},{11{1'b0}}};   // tanh inverse(2^-9) = 0.001953125
 assign look_up[10] = {{5{1'b0}},{16'b0000000001000000},{11{1'b0}}};   // tanh inverse(2^-10) = 0.0009765625
 assign look_up[11] = {{5{1'b0}},{16'b0000000000100000},{11{1'b0}}};   // tanh inverse(2^-11) = 0.00048828125
 assign look_up[12] = {{5{1'b0}},{16'b0000000000010000},{11{1'b0}}};   // tanh inverse(2^-12) = 0.000244140625
 assign look_up[13] = {{5{1'b0}},{16'b0000000000001000},{11{1'b0}}};   // tanh inverse(2^-13) = 0.0001220703125
 assign look_up[14] = {{5{1'b0}},{16'b0000000000000100},{11{1'b0}}};   // tanh inverse(2^-14) = 0.00006103515625
 assign look_up[15] = {{5{1'b0}},{16'b0000000000000010},{11{1'b0}}};   // tanh inverse(2^-15) = 0.000030517578125
 assign look_up[16] = {{5{1'b0}},{16'b0000000000000001},{11{1'b0}}};   // tanh inverse(2^-16) = 0.0000152587890625
 assign look_up[17] = {{5{1'b0}},{16{1'b0}},11'b10000000000};   // tanh inverse(2^-17) = 0.0039
 assign look_up[18] = {{5{1'b0}},{16{1'b0}},11'b01000000000};   // tanh inverse(2^-18) = 0.0039
 assign look_up[19] = {{5{1'b0}},{16{1'b0}},11'b00100000000};   // tanh inverse(2^-19) = 0.0039
 assign look_up[20] = {{5{1'b0}},{16{1'b0}},11'b00010000000};   // tanh inverse(2^-20) = 0.0039
 assign look_up[21] = {{5{1'b0}},{16{1'b0}},11'b00001000000};   // tanh inverse(2^-20) = 0.0039
 assign look_up[22] = {{5{1'b0}},{16{1'b0}},11'b00000100000};   // tanh inverse(2^-20) = 0.0039
 assign look_up[23] = {{5{1'b0}},{16{1'b0}},11'b00000010000};   // tanh inverse(2^-20) = 0.0039
 assign look_up[24] = {{5{1'b0}},{16{1'b0}},11'b00000001000};   // tanh inverse(2^-20) = 0.0039
 assign look_up[25] = {{5{1'b0}},{16{1'b0}},11'b00000000100};   // tanh inverse(2^-20) = 0.0039
 assign look_up[26] = {{5{1'b0}},{16{1'b0}},11'b00000000010};   // tanh inverse(2^-20) = 0.0039
 assign look_up[27] = {{5{1'b0}},{16{1'b0}},11'b00000000001};   // tanh inverse(2^-20) = 0.0039
  
  

 always@(posedge clk)
  begin
    if (rst == 0)
       begin
         x_res [31:0]     <= 20'b0;
         y_res [31:0]     <= 20'b0;  
       end 
    else 
       begin
         x_res [31:0] <= x[27][31:0];
         y_res [31:0] <= y[27][31:0];
       end
  end

 // Place them in a separate always block as they are fixed (This helps us avoid numerous RTL errors)
 always@(*)
   begin
      x[1] = 32'b00000000000000010011010100011110; // x[1] = 1.2075 (16 bits for the integer part and 16 bits for the fractional part)
      y[1] = 32'b00000000000000000000000000000000; // y[1] = 0.0000 (16 bits for the integer part and 16 bits for the fractional part)
      z[1] = target_angle; // First we always rotate by 0 degrees => Update the rotated angle accordingly
      d[1] = (z[1][31] == 0) ? 1 : 0;
   end
   
 integer i,j,k; 
   
 always@(*)
   begin

//step 2
//     x[2] = (d[1] == 1) ? (x[1] + (y[1]>>>1)) : (x[1]-(y[1]>>>1));
//     y[2] = (d[1] == 1) ? (y[1] + (x[1]>>>1)) : (y[1]-(x[1]>>>1));
//     z[2] = (d[1] == 1) ? (z[1] - look_up[1]) : (z[1]+look_up[1]);
//     d[2] = (z[2][31] == 0) ? 1 : 0;   
     
////step 3
//     x[3] = (d[2] == 1) ? (x[2] + (y[2]>>>2)) : (x[2]-(y[2]>>>2));
//     y[3] = (d[2] == 1) ? (y[2] + (x[2]>>>2)) : (y[2]-(x[2]>>>2));
//     z[3] = (d[2] == 1) ? (z[2] - look_up[2]) : (z[2]+look_up[2]);
//     d[3] = (z[3][31] == 0) ? 1 : 0; 
     
////step 4
//     x[4] = (d[3] == 1) ? (x[3] + (y[3]>>>3)) : (x[3]-(y[3]>>>3));
//     y[4] = (d[3] == 1) ? (y[3] + (x[3]>>>3)) : (y[3]-(x[3]>>>3));
//     z[4] = (d[3] == 1) ? (z[3] - look_up[3]) : (z[3]+look_up[3]);
//     d[4] = (z[4][31] == 0) ? 1 : 0; 

  for(i = 2; i<=4; i= i+1) 
    begin
     x[i] = (d[i-1] == 1) ? (x[i-1] + (y[i-1]>>>(i-1))) : (x[i-1]-(y[i-1]>>>(i-1)));
     y[i] = (d[i-1] == 1) ? (y[i-1] + (x[i-1]>>>(i-1))) : (y[i-1]-(x[i-1]>>>(i-1)));
     z[i] = (d[i-1] == 1) ? (z[i-1] - look_up[i-1]) : (z[i-1]+look_up[i-1]);
     d[i] = (z[i][31] == 0) ? 1 : 0;
    end

// step 4_prime (Repeat of iteration 4 for convergence purposes)
     x4 = (d[4] == 1) ? (x[4] + (y[4]>>>3)) : (x[4]-(y[4]>>>3));
     y4 = (d[4] == 1) ? (y[4] + (x[4]>>>3)) : (y[4]-(x[4]>>>3));
     z4 = (d[4] == 1) ? (z[4] - look_up[3]) : (z[4]+look_up[3]);
     d4 = (z4[31] == 0) ? 0 : 1;
         
//step 5
     x[5] = (d4 == 1) ? (x4 + (y4>>>4)) : (x4-(y4>>>4));
     y[5] = (d4 == 1) ? (y4 + (x4>>>4)) : (y4-(x4>>>4));
     z[5] = (d4 == 1) ? (z4 - look_up[4]) : (z4+look_up[4]);
     d[5] = (z[5][31] == 0) ? 1 : 0; 
     
////step 6
//     x[6] = (d[5] == 1) ? (x[5] + (y[5]>>>5)) : (x[5]-(y[5]>>>5));
//     y[6] = (d[5] == 1) ? (y[5] + (x[5]>>>5)) : (y[5]-(x[5]>>>5));
//     z[6] = (d[5] == 1) ? (z[5] - look_up[5]) : (z[5]+look_up[5]);
//     d[6] = (z[6][31] == 0) ? 1 : 0; 
     
////step 7
//     x[7] = (d[6] == 1) ? (x[6] + (y[6]>>>6)) : (x[6]-(y[6]>>>6));
//     y[7] = (d[6] == 1) ? (y[6] + (x[6]>>>6)) : (y[6]-(x[6]>>>6));
//     z[7] = (d[6] == 1) ? (z[6] - look_up[6]) : (z[6]+look_up[6]);
//     d[7] = (z[7][31] == 0) ? 1 : 0; 
     
////step 8
//     x[8] = (d[7] == 1) ? (x[7] + (y[7]>>>7)) : (x[7]-(y[7]>>>7));
//     y[8] = (d[7] == 1) ? (y[7] + (x[7]>>>7)) : (y[7]-(x[7]>>>7));
//     z[8] = (d[7] == 1) ? (z[7] - look_up[7]) : (z[7]+look_up[7]);
//     d[8] = (z[8][31] == 0) ? 1 : 0; 
     
////step 9
//     x[9] = (d[8] == 1) ? (x[8] + (y[8]>>>8)) : (x[8]-(y[8]>>>8));
//     y[9] = (d[8] == 1) ? (y[8] + (x[8]>>>8)) : (y[8]-(x[8]>>>8));
//     z[9] = (d[8] == 1) ? (z[8] - look_up[8]) : (z[8]+look_up[8]);
//     d[9] = (z[9][31] == 0) ? 1 : 0; 

   for(j = 6;j<=13;j=j+1) 
     begin
       x[j] = (d[j-1] == 1) ? (x[j-1] + (y[j-1]>>>(j-1))) : (x[j-1]-(y[j-1]>>>(j-1)));
       y[j] = (d[j-1] == 1) ? (y[j-1] + (x[j-1]>>>(j-1))) : (y[j-1]-(x[j-1]>>>(j-1)));
       z[j] = (d[j-1] == 1) ? (z[j-1] - look_up[j-1]) : (z[j-1]+look_up[j-1]);
       d[j] = (z[j][31] == 0) ? 1 : 0;
     end
     
       x13 = (d[13] == 1) ? (x[13] + (y[13]>>>12)) : (x[13]-(y[13]>>>12));
       y13 = (d[13] == 1) ? (y[13] + (x[13]>>>12)) : (y[13]-(x[13]>>>12));
       z13 = (d[13] == 1) ? (z[13] - look_up[12]) :  (z[13]+look_up[12]);
       d13 = (z13[31] == 0) ? 0 : 1;
       
// Step 14
      x[14] = (d13 == 1) ? (x13 + (y13>>>13)) : (x13-(y13>>>13));
      y[14] = (d13 == 1) ? (y13 + (x13>>>13)) : (y13-(x13>>>13));
      z[14] = (d13 == 1) ? (z13 - look_up[13]) : (z13+look_up[13]);
      d[14] = (z[14][31] == 0) ? 1 : 0; 
      
   for( k=15;k<=27;k=k+1) 
     begin
       x[k] = (d[k-1] == 1) ? (x[k-1] + (y[k-1]>>>(k-1))) : (x[k-1]-(y[k-1]>>>(k-1)));
       y[k] = (d[k-1] == 1) ? (y[k-1] + (x[k-1]>>>(k-1))) : (y[k-1]-(x[k-1]>>>(k-1)));
       z[k] = (d[k-1] == 1) ? (z[k-1] - look_up[k-1]) : (z[k-1]+look_up[k-1]);
       d[k] = (z[k][31] == 0) ? 1 : 0;
     end
   end
endmodule