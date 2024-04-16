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


module cordic_division_tan(clk,rst,x_input,y_input,z_res);

// Apparently verilog does not support two dimensional arrays as ports (system verilog does)
// However, let us see if this works for simulation

 input clk,rst;  // Input clock and reset signals
 input signed [11:0] x_input;    // 12 bits (2 bits for the integer part and 10 bits for the fractional part)
 input signed [11:0] y_input;    // 12 bits (2 bits for the integer part and 10 bits for the fractional part)
 
 output reg signed [11:0] z_res; // 12 bits (4 for integer part and 16 for fractional part) 
 
 reg signed [11:0] x_input_clk ; 
 reg signed [11:0] y_input_clk ;  
 
 reg clk2;  // Slower Clock to update division result
 reg [9:0] clk2_count_comb , clk2_count_seq; // 10 bit register that will be updated in combinational always block
  
 reg signed [11:0] x;        // to store the x results of each step (4 bits for the integer part including MSB and 16 bits for the fractional part)
 reg signed [11:0] y [9:0];  // to store the y results of each step (4 bits for the integer part including MSB and 16 bits for the fractional part)
 (*keep = "soft" *) reg signed [11:0] y10; // To overcome RTL error
  
 wire signed[11:0] look_up [9:0];       // to store look up values of arc tan using 20 bits (16 bits including MSB to denote the integer part and 4 bits to denote the fractional part)
// (*keep = "soft" *) wire signed[11:0] look_up10; // To overcome RTL error
 reg  signed[11:0] z[10:0];  // Array of 20 bit registers to store the rotated angle 
 reg  d[9:0]; // Array of 1 bit registers to denote the direction of rotation. 1/0 => Anticlockwise / Clockwise rotation 
 
 // In the look up table of (2^-i), 2 bits are used for integer and 10 bits are used for fractional part
 assign look_up[0]  = 12'b010000000000;   // 2 ^ (-0) = 1
 assign look_up[1]  = 12'b001000000000;   // 2 ^ (-1) = 0.5
 assign look_up[2]  = 12'b000100000000;   // 2 ^ (-2) = 0.25
 assign look_up[3]  = 12'b000010000000;   // 2 ^ (-3) = 0.125
 assign look_up[4]  = 12'b000001000000;   // 2 ^ (-4) = 0.0625
 assign look_up[5]  = 12'b000000100000;   // 2 ^ (-5) = 0.03125
 assign look_up[6]  = 12'b000000010000;   // 2 ^ (-6) = 0.015625
 assign look_up[7]  = 12'b000000001000;   // 2 ^ (-7) = 0.0078125
 assign look_up[8]  = 12'b000000000100;   // 2 ^ (-8) = 0.00390625
 assign look_up[9]  = 12'b000000000010;   // 2 ^ (-9) = 0.001953125
// assign look_up10   = 12'b000000000001;   // 2 ^ (-10) = 0.0009765625
 
 
 // Clocked always block to update clk2
 always@(posedge clk , negedge rst)  // Asclkhronous reset
    begin
      if(rst == 0) clk2_count_seq  <= 10'b0;              // Reset the count value for clk2     
    else 
       begin
           clk2_count_seq <= clk2_count_comb;  // Update the count value for clk2                    
           if(clk2_count_comb == 1) clk2 <= 1'b1;
           else                     clk2 <= 1'b0;
         end
    end
   
  
 always@(posedge clk2 , negedge rst)
  begin
    if (rst == 0)
      begin
         x_input_clk     <= 12'b0;
         y_input_clk     <= 12'b0;
         z_res <= 12'b0; 
      end  
    else 
      begin
         x_input_clk <= x_input;
         y_input_clk <= y_input;
         z_res <= z[10][11:0]; 
      end
  end
 
// 5 clock pulses to generate a clock signal of period 50ns (frequency of 20MHz)   
always@(*)
  begin
    if(clk2_count_seq == 4)      clk2_count_comb = 0;
    else                         clk2_count_comb = clk2_count_seq + 1;  
  end
  
  
  
 // Place them in a separate always block as they are fixed (This helps us avoid numerous RTL errors)
 always@(*)
   begin
      x    = x_input_clk; // x[0] = 0.6072 (4 bits for the integer part and 10 bits for the fractional part)
      y[0] = y_input_clk; // y[0] = 0.0000 (4 bits for the integer part and 10 bits for the fractional part)
      z[0] = 12'b0; 
      d[0] = ((x[11] ^ (y[0][11])) == 0) ? 0 : 1;  
   end
   
 integer i;
 always@(*)
   begin
      for(i = 1 ; i<= 10;i = i+1)
        begin
         y[i] = (d[i-1] == 1) ? (y[i-1] + (x>>>(i-1)) ) : (y[i-1]- (x>>>(i-1)) );
         z[i] = (d[i-1] == 1) ? (z[i-1] - look_up[i-1]) : (z[i-1]+look_up[i-1]);
         d[i] = ((x[11] ^ (y[i][11])) == 0) ? 0 : 1;
        end
        
        y10   = (d[9] == 1) ? (y[9] + (x>>>(9)) ) : (y[9]- (x>>>(9)) );
        z[10] = (d[9] == 1) ? (z[9] - look_up[9]) : (z[9]+look_up[9]); 
        
     end
endmodule



