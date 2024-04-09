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


module cordic_tan_inverse(clk,rst,y_input,z_res);


 input clk,rst;  // Input clock and reset signalsq
 input signed [19:0] y_input;   // 20 bits to denote the y input (16 bits including MSB for the integer part and 4 bits for the fractional part)
 
 output reg signed [19:0] z_res; // 20 bits (4 for integer part and 16 for fractional part) 
 
 reg signed [19:0] y_input_clk ;  // to store the y input (4 bits for the integer part including MSB and 16 bits for the fractional part)
 
 reg signed [19:0] x [10:0];  // to store the x results of each step (4 bits for the integer part including MSB and 16 bits for the fractional part)
 reg signed [19:0] y [10:0];  // to store the y results of each step (4 bits for the integer part including MSB and 16 bits for the fractional part)
 
 wire signed[19:0] look_up [9:0];       // to store look up values of arc tan using 20 bits (16 bits including MSB to denote the integer part and 4 bits to denote the fractional part)
 reg  signed[19:0] z[10:0];  // Array of 20 bit registers to store the rotated angle 
 reg  d[10:0]; // Array of 1 bit registers to denote the direction of rotation. 1/0 => Anticlockwise / Clockwise rotation 
 
 // In the look up table of tan inverse (2^-i), 16 bits are used for the integer part and 4 bits for the fractional part
 assign look_up[0] = {{6{1'b0}},10'b0000101101,4'b0000};   // 45      degrees
 assign look_up[1] = {{6{1'b0}},10'b0000011010,4'b1001};   // 26.565  degrees
 assign look_up[2] = {{6{1'b0}},10'b0000001110,4'b0000};   // 14.0362 degrees
 assign look_up[3] = {{6{1'b0}},10'b0000000111,4'b0010};   // 7.125   degrees
 assign look_up[4] = {{6{1'b0}},10'b0000000011,4'b1001};   // 3.5763  degrees
 assign look_up[5] = {{6{1'b0}},10'b0000000001,4'b1100};   // 1.7899  degrees
 assign look_up[6] = {{6{1'b0}},10'b0000000000,4'b1110};   // 0.8951  degrees
 assign look_up[7] = {{6{1'b0}},10'b0000000000,4'b0111};   // 0.4476  degrees
 assign look_up[8] = {{6{1'b0}},10'b0000000000,4'b0011};   // 0.2238  degrees
 assign look_up[9] = {{6{1'b0}},10'b0000000000,4'b0001};   // 0.1119  degrees

 always@(posedge clk)
  begin
    if (rst == 0)
      begin
         y_input_clk     <= 20'b0;
         z_res <= 20'b0; 
      end  
    else 
      begin
         y_input_clk <= y_input;
         if(y_input_clk == 0)z_res <= 20'b0;          // for 0 the result must be 0. Doing this to remove the error inherent with CORDIC
         else                z_res <= z[10][19:0];
      end
  end
 
 
 // Place them in a separate always block as they are fixed (This helps us avoid numerous RTL errors)
 always@(*)
   begin
      x[0] = 20'b1; 
      y[0] = y_input_clk; 
      z[0] = 20'b0; 
      d[0] = ((x[0][19] ^ (y[0][19])) == 0) ? 0 : 1;  
   end
   
   
 always@(*)
   begin

//step 1
     x[1] = (d[0] == 1) ? (x[0]-y[0]) : (x[0]+y[0]);     
     y[1] = (d[0] == 1) ? (y[0]+x[0]) : (y[0]-x[0]);
     z[1] = (d[0] == 1) ? (z[0] - look_up[0]) : (z[0]+look_up[0]);
     d[1] = (( (x[1][19]) ^ (y[1][19]) ) == 0) ? 0 : 1;
      
//step 2
     x[2] = (d[1] == 1) ? (x[1] - (y[1]>>>1)) : (x[1]+(y[1]>>>1));
     y[2] = (d[1] == 1) ? (y[1] + (x[1]>>>1)) : (y[1]-(x[1]>>>1));
     z[2] = (d[1] == 1) ? (z[1] - look_up[1]) : (z[1]+look_up[1]);
     d[2] = (( (x[2][19]) ^ (y[2][19]) ) == 0) ? 0 : 1;
     
//step 3
     x[3] = (d[2] == 1) ? (x[2] - (y[2]>>>2)) : (x[2]+(y[2]>>>2));
     y[3] = (d[2] == 1) ? (y[2] + (x[2]>>>2)) : (y[2]-(x[2]>>>2));
     z[3] = (d[2] == 1) ? (z[2] - look_up[2]) : (z[2]+look_up[2]);
     d[3] = (( (x[3][19]) ^ (y[3][19]) ) == 0) ? 0 : 1;
     
//step 4
     x[4] = (d[3] == 1) ? (x[3] - (y[3]>>>3)) : (x[3]+(y[3]>>>3));
     y[4] = (d[3] == 1) ? (y[3] + (x[3]>>>3)) : (y[3]-(x[3]>>>3));
     z[4] = (d[3] == 1) ? (z[3] - look_up[3]) : (z[3]+look_up[3]);
     d[4] = (( (x[4][19]) ^ (y[4][19]) ) == 0) ? 0 : 1;
     
//step 5
     x[5] = (d[4] == 1) ? (x[4] - (y[4]>>>4)) : (x[4]+(y[4]>>>4));
     y[5] = (d[4] == 1) ? (y[4] + (x[4]>>>4)) : (y[4]-(x[4]>>>4));
     z[5] = (d[4] == 1) ? (z[4] - look_up[4]) : (z[4]+look_up[4]);
     d[5] = (( (x[5][19]) ^ (y[5][19]) ) == 0) ? 0 : 1;
     
//step 6
     x[6] = (d[5] == 1) ? (x[5] - (y[5]>>>5)) : (x[5]+(y[5]>>>5));
     y[6] = (d[5] == 1) ? (y[5] + (x[5]>>>5)) : (y[5]-(x[5]>>>5));
     z[6] = (d[5] == 1) ? (z[5] - look_up[5]) : (z[5]+look_up[5]);
     d[6] = (( (x[6][19]) ^ (y[6][19]) ) == 0) ? 0 : 1;
     
//step 7
     x[7] = (d[6] == 1) ? (x[6] - (y[6]>>>6)) : (x[6]+(y[6]>>>6));
     y[7] = (d[6] == 1) ? (y[6] + (x[6]>>>6)) : (y[6]-(x[6]>>>6));
     z[7] = (d[6] == 1) ? (z[6] - look_up[6]) : (z[6]+look_up[6]);
     d[7] = (( (x[7][19]) ^ (y[7][19]) ) == 0) ? 0 : 1;
     
//step 8
     x[8] = (d[7] == 1) ? (x[7] - (y[7]>>>7)) : (x[7]+(y[7]>>>7));
     y[8] = (d[7] == 1) ? (y[7] + (x[7]>>>7)) : (y[7]-(x[7]>>>7));
     z[8] = (d[7] == 1) ? (z[7] - look_up[7]) : (z[7]+look_up[7]);
     d[8] = (( (x[8][19]) ^ (y[8][19]) ) == 0) ? 0 : 1;
     
//step 9
     x[9] = (d[8] == 1) ? (x[8] - (y[8]>>>8)) : (x[8]+(y[8]>>>8));
     y[9] = (d[8] == 1) ? (y[8] + (x[8]>>>8)) : (y[8]-(x[8]>>>8));
     z[9] = (d[8] == 1) ? (z[8] - look_up[8]) : (z[8]+look_up[8]);
     d[9] = (( (x[9][19]) ^ (y[9][19]) ) == 0) ? 0 : 1;

//step 10
     x[10] = (d[9] == 1) ? (x[9] - (y[1]>>>9)) : (x[9]+(y[9]>>>9));
     y[10] = (d[9] == 1) ? (y[9] + (x[1]>>>9)) : (y[9]-(x[9]>>>9));
     z[10] = (d[9] == 1) ? (z[9] - look_up[9]) : (z[9]+look_up[9]);
     d[10] = (( (x[10][19]) ^ (y[10][19]) ) == 0) ? 0 : 1;
   end

endmodule

