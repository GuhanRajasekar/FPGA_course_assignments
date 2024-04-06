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


module cordic_sin_cos_dac(slide_switch,clk,rst,x_res,y_res);
  input clk, rst;
  input signed [11:0] slide_switch;
  
  output reg signed [11:0] x_res;
  output reg signed [11:0] y_res;
  
  reg clk1, clk2;
  reg [3:0] clk1_count_comb, clk2_count_comb; // 4 bit registers that will be updated in combinational always block
  reg [3:0] clk1_count_seq,  clk2_count_seq;  // 4 bit registers that will be updated in sequential (clocked) always block 
  
  
  always@(posedge clk)
    begin
      if(rst == 0)
         begin
           clk1_count_seq <= 4'b0000;              // Reset the count value for clk1
           clk2_count_seq <= 4'b0000;              // Reset the count value for clk2
         end 
      else 
         begin
           clk1_count_seq <= clk1_count_comb;  // Update the count value for clk1
           clk2_count_seq <= clk2_count_comb;  // Update the count value for clk2
           
           if(clk1_count_comb == 1) clk1 <= 1'b1;
           else                     clk1 <= 1'b0;
           
           if(clk2_count_comb == 1) clk2 <= 1'b1;
           else                     clk2 <= 1'b0;
         end
    end

// 5 clock pulses to generate a clock signal of period 50ns (frequency of 20MHz)   
// This clock (clk1) will be used to compute the updated angle value 
always@(*)
  begin
    if(clk1_count_seq == 4)      clk1_count_comb = 0;
    else                         clk1_count_comb = clk1_count_seq + 1;    
  end

// 3 clock pulses to generate a clock signal of period 30ns (frequency of 33.33 MHz)
// This clock (clk2) will be used to compute cosz and sinz value in 10 iterations
always@(*)
  begin
    if(clk2_count_seq == 2)      clk2_count_comb = 0;
    else                         clk2_count_comb = clk2_count_seq + 1;  
  end
  
endmodule
