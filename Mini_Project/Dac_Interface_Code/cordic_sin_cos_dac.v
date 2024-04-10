`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2024 12:03:14
// Design Name: 
// Module Name: cordic_sin_cos_dac
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
module get_conv_output(quad_loc, x,y,x_res,y_res);
   input [2:0] quad_loc;
   input signed [11:0] x,y;
   output reg signed [11:0] x_res,y_res;
   
   // Get the appropraite x result (cos z)
   always@(*)
     begin
        case(quad_loc)
             1: x_res = x;
             2: x_res = -y;
             3: x_res = -x;
             4: x_res = y;
       default: x_res = x; // To avoid inferred latch condition
       endcase
     end
     
   // Get the appropriate y result (sin z)
   always@(*)
     begin
        case(quad_loc)
             1: y_res = y;
             2: y_res = x;
             3: y_res = -y;
             4: y_res = -x;
       default: y_res = y;  // To avoid inferring latches
       endcase
     end
endmodule

module get_conv_angle(z_seq,z_conv,quad_loc);
  input signed [12:0] z_seq;        
  output reg   [12:0] z_conv;  
  output reg   [2:0] quad_loc; // quadrant location must not be signed
  
  // Combinational always block to find out the quadrant in which the target angle is present
  always@(*)
    begin
      if(z_seq >= 0 && z_seq<=1024)          quad_loc = 1;   // Target Angle in First  Quadrant
      else if(z_seq > 1024 && z_seq <= 2048) quad_loc = 2;   // Target Angle in Second Quadrant
      else if(z_seq > 2048 && z_seq <= 3072) quad_loc = 3;   // Target Angle in Third  Quadrant
      else                                   quad_loc = 4;   // Target Angle in Fourth Quadrant
    end
 
 // Combinational always block to compute the converted target angle 
  always@(*)
    begin
      if      (z_seq >= 0   && z_seq <= 1024) z_conv = z_seq;
      else if (z_seq > 1024 && z_seq <= 2048) z_conv = z_seq - 1024;
      else if (z_seq > 2048 && z_seq <= 3072) z_conv = z_seq - 2048;
      else                                    z_conv = z_seq - 3072;
    end
endmodule

module cordic_sin_cos_dac(slide_switch,clk,rst,x_res_seq,y_res_seq);
  input clk, rst;
  input signed [12:0] slide_switch; // MSB switch must always be held low. 
  
  output reg [11:0] x_res_seq; // signed register to hold cosz
  output reg [11:0] y_res_seq; // signed register to hold sinz
  
  wire signed [11:0] x_res_wire; // 
  wire signed [11:0] y_res_wire; // signed register to hold sinz
  
  reg clk2;
  reg [9:0] clk2_count_comb; // 10 bit register that will be updated in combinational always block
//  reg [9:0] sclk_count_comb ; // 10 bit register that wil be  updated in combinational always block
//  reg [9:0] sync_count_comb;
  
  
  reg [9:0] clk2_count_seq;  // 10 bit register that will be updated in sequential (clocked) always block 
//  reg [9:0] sclk_count_seq;  // 10 bit register that will be udpated in sequential (clocked) always block
//  reg [9:0] sync_count_seq;  // 10 bit register that will be udpated in sequential (clocked) always block
  

  
  wire signed [12:0] look_up [8:0]; // 9 arrays, each of 12 bits width to store look up angle
  reg  signed [12:0] z_comb, z_seq; 
  wire[2:0]  quad_loc;   // 3 bit wire to denote the quadrant location (quadrant location must NOT be signed)
  
  reg signed [11:0] x [9:1];  // to store the x-coordinates of each step (3 bits for the integer part including MSB and 9 bits for the fractional part)
  reg signed [11:0] y [9:1];  // to store the y-coordinates of each step (3 bits for the integer part including MSB and 9 bits for the fractional part)
  reg signed [12:0] z [8:1];         // Array of 12 bit registers to store the rotated angle (angle MUST NOT be signed)
  
  (* keep="soft" *) reg signed [12:0] z9 ; // Inform the synthesis tool that z9 is not critical for the design
  reg  d[8:1]; // Array of 1 bit registers to denote the direction of rotation. 1/0 => Anticlockwise / Clockwise rotation 
  
  // The following vector of wires will be driven with the initial values that are required to compute cosz and sinz
  wire signed [11:0] x0; 
  wire signed [11:0] y0;
  wire signed [12:0] z0;
//  wire  d0;          
   
//// Clocked always block to update sclk signal
//always@(posedge clk, negedge rst)
//   begin
//     if(rst == 0) sclk_count_seq <= 1'b0;  // Reset the sclk count 
//     else 
//        begin
//          sclk_count_seq <= sclk_count_comb;
//          if(sclk_count_comb == 1) sclk <= 1'b1;  // sclk signal is active
//          else                     sclk <= 1'b0;  // sclk signal is deactivated
//        end
//   end

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


// Sequential always block to update the angle value at 1.25MHz
always@(posedge clk2 , negedge rst)  // Asclkhronous reset
  begin
    if(rst == 1'b0)
       begin
          z_seq <= 13'b0;
          x_res_seq <= 12'b0;
          x_res_seq <= 12'b0;
//          dummy     <= 13'b0;
       end
    else 
       begin
       // The updated angle (z_seq)  and the results are computed at the falling edge of clk2 signal whose frequency is 20MHz
          if(z_comb < 0) z_seq <= 13'b0;
          else           z_seq <= z_comb;
          x_res_seq <= $unsigned(x_res_wire + 12'h800);
          y_res_seq <= $unsigned(y_res_wire + 12'h800);         
       end
  end


//always@(posedge sclk, negedge rst)
//  begin
//     if(rst == 1'b0) 
//       begin
//          sync <= 1'b1;
//          sync_count_seq <= 1'b0;
//       end
       
//     else 
//       begin
//          if(clk2 == 1'b1)          sync <= 0;
//          else 
//            begin
//              if(sync_count_seq == 17) sync<= 1;
//              if(sync == 0)  sync_count_seq <= sync_count_comb;
//              else           sync_count_seq <= 0;
//            end
//       end
//  end

   
//always@(*)
//  begin
//     if(sync_count_seq == 17) sync_count_comb = 0;
//     else                     sync_count_comb = sync_count_seq + 1;
//  end
  
  
// 3 clock pulses to generate a clock signal of period 30ns (frequency of 33.33 MHz)
// This clock (clk2) will be used to compute cosz and sinz value in 10 iterations
//always@(*)
//  begin
//    if(clk1_count_seq == 2)      clk1_count_comb = 0;
//    else                         clk1_count_comb = clk1_count_seq + 1;    
//  end

// 5 clock pulses to generate a clock signal of period 50ns (frequency of 20MHz)   
always@(*)
  begin
    if(clk2_count_seq == 4)     clk2_count_comb = 0;
    else                         clk2_count_comb = clk2_count_seq + 1;  
  end

// 4 clock pulses of 10ns clock will contribute to 1 clock pulse of sclk (clock signal for the DAC)
//always@(*)
//   begin
//    if(sclk_count_seq == 3)      sclk_count_comb = 0;
//    else                         sclk_count_comb = sclk_count_seq + 1;
//   end

// Combinational always block to update the angle
always@(*) z_comb = z_seq + 1 + slide_switch;  
 

  
 // filling up the look up table with tan inverse values
 assign look_up[0] = 512;  // corresponds to 45         degrees
 assign look_up[1] = 302;  // corresponds to 26.565     degrees
 assign look_up[2] = 160;  // corresponds to 14.3055    degrees
 assign look_up[3] = 81;   // corresponds to 7.125      degrees
 assign look_up[4] = 41;   // corresponds to 3.57633    degrees
 assign look_up[5] = 20;   // corresponds to 1.7899     degrees
 assign look_up[6] = 10;   // corresponds to 0.89517    degrees
 assign look_up[7] = 5;    // corresponds to 0.447614   degrees
 assign look_up[8] = 3;    // corresponds to 0.2238105  degrees
 
get_conv_angle  guhan(.z_seq(z_seq), .z_conv(z0),.quad_loc(quad_loc));
get_conv_output hari (.quad_loc(quad_loc), .x(x[9]), .y(y[9]), .x_res(x_res_wire), .y_res(y_res_wire));
 
 // Initial values that are required for CORDIC (initialized using Data Flow Style of Modelling)
 assign x0 = 12'b010011011011 ; // x0 = 0.6073 (1 bits for the integer part and 11 bits for the fractional part)
 assign y0 = 12'b000000000000 ; // y0 = 0 (1 bits for the integer part and 11 bits for the fractional part)
// assign d0 = 1'b1;  

// Combinational always block to compute cosz and sinz in 10 iterations
always@(*)
   begin
//step 1
     x[1] = (x0 - y0);
     y[1] = (y0 + x0);
     z[1] = (z0 - look_up[0]);
     d[1] = (z[1][11] == 0) ? 1 : 0;
      
//step 2
     x[2] = (d[1] == 1) ? (x[1] - (y[1]>>>1)) : (x[1]+(y[1]>>>1));
     y[2] = (d[1] == 1) ? (y[1] + (x[1]>>>1)) : (y[1]-(x[1]>>>1));
     z[2] = (d[1] == 1) ? (z[1] - look_up[1]) : (z[1]+look_up[1]);
     d[2] = (z[2][11] == 0) ? 1 : 0;   
     
//step 3
     x[3] = (d[2] == 1) ? (x[2] - (y[2]>>>2)) : (x[2]+(y[2]>>>2));
     y[3] = (d[2] == 1) ? (y[2] + (x[2]>>>2)) : (y[2]-(x[2]>>>2));
     z[3] = (d[2] == 1) ? (z[2] - look_up[2]) : (z[2]+look_up[2]);
     d[3] = (z[3][11] == 0) ? 1 : 0; 
     
//step 4
     x[4] = (d[3] == 1) ? (x[3] - (y[3]>>>3)) : (x[3]+(y[3]>>>3));
     y[4] = (d[3] == 1) ? (y[3] + (x[3]>>>3)) : (y[3]-(x[3]>>>3));
     z[4] = (d[3] == 1) ? (z[3] - look_up[3]) : (z[3]+look_up[3]);
     d[4] = (z[4][11] == 0) ? 1 : 0; 
     
//step 5
     x[5] = (d[4] == 1) ? (x[4] - (y[4]>>>4)) : (x[4]+(y[4]>>>4));
     y[5] = (d[4] == 1) ? (y[4] + (x[4]>>>4)) : (y[4]-(x[4]>>>4));
     z[5] = (d[4] == 1) ? (z[4] - look_up[4]) : (z[4]+look_up[4]);
     d[5] = (z[5][11] == 0) ? 1 : 0; 
     
//step 6
     x[6] = (d[5] == 1) ? (x[5] - (y[5]>>>5)) : (x[5]+(y[5]>>>5));
     y[6] = (d[5] == 1) ? (y[5] + (x[5]>>>5)) : (y[5]-(x[5]>>>5));
     z[6] = (d[5] == 1) ? (z[5] - look_up[5]) : (z[5]+look_up[5]);
     d[6] = (z[6][11] == 0) ? 1 : 0; 
     
//step 7
     x[7] = (d[6] == 1) ? (x[6] - (y[6]>>>6)) : (x[6]+(y[6]>>>6));
     y[7] = (d[6] == 1) ? (y[6] + (x[6]>>>6)) : (y[6]-(x[6]>>>6));
     z[7] = (d[6] == 1) ? (z[6] - look_up[6]) : (z[6]+look_up[6]);
     d[7] = (z[7][11] == 0) ? 1 : 0; 
     
//step 8
     x[8] = (d[7] == 1) ? (x[7] - (y[7]>>>7)) : (x[7]+(y[7]>>>7));
     y[8] = (d[7] == 1) ? (y[7] + (x[7]>>>7)) : (y[7]-(x[7]>>>7));
     z[8] = (d[7] == 1) ? (z[7] - look_up[7]) : (z[7]+look_up[7]);
     d[8] = (z[8][11] == 0) ? 1 : 0; 
     
//step 9
     x[9] = (d[8] == 1) ? (x[8] - (y[8]>>>8)) : (x[8]+(y[8]>>>8));
     y[9] = (d[8] == 1) ? (y[8] + (x[8]>>>8)) : (y[8]-(x[8]>>>8));
     z9 = (d[8] == 1) ? (z[8] - look_up[8]) : (z[8]+look_up[8]);
//     d[9] = (z[9][11] == 0) ? 1 : 0; 
   end

endmodule