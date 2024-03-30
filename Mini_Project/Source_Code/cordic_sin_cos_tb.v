`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2024 13:16:37
// Design Name: 
// Module Name: cordic_sin_cos_tb
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


module cordic_sin_cos_tb;
  reg  signed  [19:0] target_angle;
  reg clk,rst;
  wire signed [19:0] x_res;
  wire signed [19:0] y_res;
  cordic_sin_cos c(.clk(clk),.rst(rst),.target_angle(target_angle), .x_res(x_res) , .y_res(y_res));
  
  // Always block to keep toggling the clock signal
  always #2 clk = ~clk;
  
  initial
     begin
       // here we define the target angle
       // 16 bits for the integer part and 4 bits for the fractional part of the target angle
       #0 clk = 1'b0; rst = 1'b0;
       #1 rst = 1'b1; 
       // In target_angle, we have 58.54 (16 bits for integer part and 4 bits for the fractional part)
       
            #10 target_angle = 20'b00000000000000000000; // 0 degrees
            #10 target_angle = 20'b00000000000000010000; // 1 degrees
            #10 target_angle = 20'b00000000000000100000; // 2 degrees
            #10 target_angle = 20'b00000000000000110000; // 3 degrees
            #10 target_angle = 20'b00000000000001000000; // 4 degrees
            #10 target_angle = 20'b00000000000001010000; // 5 degrees
            #10 target_angle = 20'b00000000000001100000; // 6 degrees
            #10 target_angle = 20'b00000000000001110000; // 7 degrees
            #10 target_angle = 20'b00000000000010000000; // 8 degrees
            #10 target_angle = 20'b00000000000010010000; // 9 degrees
            #10 target_angle = 20'b00000000000010100000; // 10 degrees
            #10 target_angle = 20'b00000000000010110000; // 11 degrees
            #10 target_angle = 20'b00000000000011000000; // 12 degrees
            #10 target_angle = 20'b00000000000011010000; // 13 degrees
            #10 target_angle = 20'b00000000000011100000; // 14 degrees
            #10 target_angle = 20'b00000000000011110000; // 15 degrees
            #10 target_angle = 20'b00000000000100000000; // 16 degrees
            #10 target_angle = 20'b00000000000100010000; // 17 degrees
            #10 target_angle = 20'b00000000000100100000; // 18 degrees
            #10 target_angle = 20'b00000000000100110000; // 19 degrees
            #10 target_angle = 20'b00000000000101000000; // 20 degrees
            #10 target_angle = 20'b00000000000101010000; // 21 degrees
            #10 target_angle = 20'b00000000000101100000; // 22 degrees
            #10 target_angle = 20'b00000000000101110000; // 23 degrees
            #10 target_angle = 20'b00000000000110000000; // 24 degrees
            #10 target_angle = 20'b00000000000110010000; // 25 degrees
            
            #10 target_angle = 20'b00000000000110100000; // 26 degrees
            #10 target_angle = 20'b00000000000110110000; // 27 degrees
            #10 target_angle = 20'b00000000000111000000; // 28 degrees
            #10 target_angle = 20'b00000000000111010000; // 29 degrees
            #10 target_angle = 20'b00000000000111100000; // 30 degrees
            #10 target_angle = 20'b00000000000111110000; // 31 degrees
            #10 target_angle = 20'b00000000001000000000; // 32 degrees
            #10 target_angle = 20'b00000000001000010000; // 33 degrees
            #10 target_angle = 20'b00000000001000100000; // 34 degrees
            #10 target_angle = 20'b00000000001000110000; // 35 degrees
            #10 target_angle = 20'b00000000001001000000; // 36 degrees
            #10 target_angle = 20'b00000000001001010000; // 37 degrees
            #10 target_angle = 20'b00000000001001100000; // 38 degrees
            #10 target_angle = 20'b00000000001001110000; // 39 degrees
            #10 target_angle = 20'b00000000001010000000; // 40 degrees
            #10 target_angle = 20'b00000000001010010000; // 41 degrees
            #10 target_angle = 20'b00000000001010100000; // 42 degrees
            #10 target_angle = 20'b00000000001010110000; // 43 degrees
            #10 target_angle = 20'b00000000001011000000; // 44 degrees
            #10 target_angle = 20'b00000000001011010000; // 45 degrees
            #10 target_angle = 20'b00000000001011100000; // 46 degrees
            #10 target_angle = 20'b00000000001011110000; // 47 degrees
            #10 target_angle = 20'b00000000001100000000; // 48 degrees
            #10 target_angle = 20'b00000000001100010000; // 49 degrees
            #10 target_angle = 20'b00000000001100100000; // 50 degrees
            
            #10 target_angle = 20'b00000000001100110000; // 51 degrees
            #10 target_angle = 20'b00000000001101000000; // 52 degrees
            #10 target_angle = 20'b00000000001101010000; // 53 degrees
            #10 target_angle = 20'b00000000001101100000; // 54 degrees
            #10 target_angle = 20'b00000000001101110000; // 55 degrees
            #10 target_angle = 20'b00000000001110000000; // 56 degrees
            #10 target_angle = 20'b00000000001110010000; // 57 degrees
            #10 target_angle = 20'b00000000001110100000; // 58 degrees
            #10 target_angle = 20'b00000000001110110000; // 59 degrees
            #10 target_angle = 20'b00000000001111000000; // 60 degrees
            #10 target_angle = 20'b00000000001111010000; // 61 degrees
            #10 target_angle = 20'b00000000001111100000; // 62 degrees
            #10 target_angle = 20'b00000000001111110000; // 63 degrees
            #10 target_angle = 20'b00000000010000000000; // 64 degrees
            #10 target_angle = 20'b00000000010000010000; // 65 degrees
            #10 target_angle = 20'b00000000010000100000; // 66 degrees
            #10 target_angle = 20'b00000000010000110000; // 67 degrees
            #10 target_angle = 20'b00000000010001000000; // 68 degrees
            #10 target_angle = 20'b00000000010001010000; // 69 degrees
            #10 target_angle = 20'b00000000010001100000; // 70 degrees
            #10 target_angle = 20'b00000000010001110000; // 71 degrees
            #10 target_angle = 20'b00000000010010000000; // 72 degrees
            #10 target_angle = 20'b00000000010010010000; // 73 degrees
            #10 target_angle = 20'b00000000010010100000; // 74 degrees
            #10 target_angle = 20'b00000000010010110000; // 75 degrees

            #10 target_angle = 20'b00000000010011000000; // 76 degrees
            #10 target_angle = 20'b00000000010011010000; // 77 degrees
            #10 target_angle = 20'b00000000010011100000; // 78 degrees
            #10 target_angle = 20'b00000000010011110000; // 79 degrees
            #10 target_angle = 20'b00000000010100000000; // 80 degrees
            #10 target_angle = 20'b00000000010100010000; // 81 degrees
            #10 target_angle = 20'b00000000010100100000; // 82 degrees
            #10 target_angle = 20'b00000000010100110000; // 83 degrees
            #10 target_angle = 20'b00000000010101000000; // 84 degrees
            #10 target_angle = 20'b00000000010101010000; // 85 degrees
            #10 target_angle = 20'b00000000010101100000; // 86 degrees
            #10 target_angle = 20'b00000000010101110000; // 87 degrees
            #10 target_angle = 20'b00000000010110000000; // 88 degrees
            #10 target_angle = 20'b00000000010110010000; // 89 degrees
            #10 target_angle = 20'b00000000010110100000; // 90 degrees
            
       #20 $finish;
     end
endmodule
