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
      $monitor("%b",x_res); 
       // here we define the target angle
       // 16 bits for the integer part and 4 bits for the fractional part of the target angle
       #0 clk = 1'b0; rst = 1'b0;
       #1 rst = 1'b1; 
       // In target_angle, we have 58.54 (16 bits for integer part and 4 bits for the fractional part)
       
//            #15 target_angle = 20'b00000000000000000000; // 0 degrees
//            #15 target_angle = 20'b00000000000000010000; // 1 degrees
//            #15 target_angle = 20'b00000000000000100000; // 2 degrees
//            #15 target_angle = 20'b00000000000000110000; // 3 degrees
//            #15 target_angle = 20'b00000000000001000000; // 4 degrees
//            #15 target_angle = 20'b00000000000001010000; // 5 degrees
//            #15 target_angle = 20'b00000000000001100000; // 6 degrees
//            #15 target_angle = 20'b00000000000001110000; // 7 degrees
//            #15 target_angle = 20'b00000000000010000000; // 8 degrees
//            #15 target_angle = 20'b00000000000010010000; // 9 degrees
//            #15 target_angle = 20'b00000000000010100000; // 10 degrees
//            #15 target_angle = 20'b00000000000010110000; // 11 degrees
//            #15 target_angle = 20'b00000000000011000000; // 12 degrees
//            #15 target_angle = 20'b00000000000011010000; // 13 degrees
//            #15 target_angle = 20'b00000000000011100000; // 14 degrees
//            #15 target_angle = 20'b00000000000011110000; // 15 degrees
//            #15 target_angle = 20'b00000000000100000000; // 16 degrees
//            #15 target_angle = 20'b00000000000100010000; // 17 degrees
//            #15 target_angle = 20'b00000000000100100000; // 18 degrees
//            #15 target_angle = 20'b00000000000100110000; // 19 degrees
//            #15 target_angle = 20'b00000000000101000000; // 20 degrees
//            #15 target_angle = 20'b00000000000101010000; // 21 degrees
//            #15 target_angle = 20'b00000000000101100000; // 22 degrees
//            #15 target_angle = 20'b00000000000101110000; // 23 degrees
//            #15 target_angle = 20'b00000000000110000000; // 24 degrees
//            #15 target_angle = 20'b00000000000110010000; // 25 degrees            
//            #15 target_angle = 20'b00000000000110100000; // 26 degrees
//            #15 target_angle = 20'b00000000000110110000; // 27 degrees
//            #15 target_angle = 20'b00000000000111000000; // 28 degrees
//            #15 target_angle = 20'b00000000000111010000; // 29 degrees
//            #15 target_angle = 20'b00000000000111100000; // 30 degrees
//            #15 target_angle = 20'b00000000000111110000; // 31 degrees
//            #15 target_angle = 20'b00000000001000000000; // 32 degrees
//            #15 target_angle = 20'b00000000001000010000; // 33 degrees
//            #15 target_angle = 20'b00000000001000100000; // 34 degrees
//            #15 target_angle = 20'b00000000001000110000; // 35 degrees
//            #15 target_angle = 20'b00000000001001000000; // 36 degrees
//            #15 target_angle = 20'b00000000001001010000; // 37 degrees
//            #15 target_angle = 20'b00000000001001100000; // 38 degrees
//            #15 target_angle = 20'b00000000001001110000; // 39 degrees
//            #15 target_angle = 20'b00000000001010000000; // 40 degrees
//            #15 target_angle = 20'b00000000001010010000; // 41 degrees
//            #15 target_angle = 20'b00000000001010100000; // 42 degrees
//            #15 target_angle = 20'b00000000001010110000; // 43 degrees
//            #15 target_angle = 20'b00000000001011000000; // 44 degrees
//            #15 target_angle = 20'b00000000001011010000; // 45 degrees

//            #15 target_angle = 20'b00000000001011100000; // 46 degrees
//            #15 target_angle = 20'b00000000001011110000; // 47 degrees
//            #15 target_angle = 20'b00000000001100000000; // 48 degrees
//            #15 target_angle = 20'b00000000001100010000; // 49 degrees
//            #15 target_angle = 20'b00000000001100100000; // 50 degrees           
//            #15 target_angle = 20'b00000000001100110000; // 51 degrees
//            #15 target_angle = 20'b00000000001101000000; // 52 degrees
//            #15 target_angle = 20'b00000000001101010000; // 53 degrees
//            #15 target_angle = 20'b00000000001101100000; // 54 degrees
//            #15 target_angle = 20'b00000000001101110000; // 55 degrees
//            #15 target_angle = 20'b00000000001110000000; // 56 degrees
//            #15 target_angle = 20'b00000000001110010000; // 57 degrees
//            #15 target_angle = 20'b00000000001110100000; // 58 degrees
//            #15 target_angle = 20'b00000000001110110000; // 59 degrees
//            #15 target_angle = 20'b00000000001111000000; // 60 degrees
//            #15 target_angle = 20'b00000000001111010000; // 61 degrees
//            #15 target_angle = 20'b00000000001111100000; // 62 degrees
//            #15 target_angle = 20'b00000000001111110000; // 63 degrees
//            #15 target_angle = 20'b00000000010000000000; // 64 degrees
//            #15 target_angle = 20'b00000000010000010000; // 65 degrees
//            #15 target_angle = 20'b00000000010000100000; // 66 degrees
//            #15 target_angle = 20'b00000000010000110000; // 67 degrees
//            #15 target_angle = 20'b00000000010001000000; // 68 degrees
//            #15 target_angle = 20'b00000000010001010000; // 69 degrees
//            #15 target_angle = 20'b00000000010001100000; // 70 degrees
//            #15 target_angle = 20'b00000000010001110000; // 71 degrees
//            #15 target_angle = 20'b00000000010010000000; // 72 degrees
//            #15 target_angle = 20'b00000000010010010000; // 73 degrees
//            #15 target_angle = 20'b00000000010010100000; // 74 degrees
//            #15 target_angle = 20'b00000000010010110000; // 75 degrees
//            #15 target_angle = 20'b00000000010011000000; // 76 degrees
//            #15 target_angle = 20'b00000000010011010000; // 77 degrees
//            #15 target_angle = 20'b00000000010011100000; // 78 degrees
//            #15 target_angle = 20'b00000000010011110000; // 79 degrees
//            #15 target_angle = 20'b00000000010100000000; // 80 degrees
//            #15 target_angle = 20'b00000000010100010000; // 81 degrees
//            #15 target_angle = 20'b00000000010100100000; // 82 degrees
//            #15 target_angle = 20'b00000000010100110000; // 83 degrees
//            #15 target_angle = 20'b00000000010101000000; // 84 degrees
//            #15 target_angle = 20'b00000000010101010000; // 85 degrees
//            #15 target_angle = 20'b00000000010101100000; // 86 degrees
//            #15 target_angle = 20'b00000000010101110000; // 87 degrees
//            #15 target_angle = 20'b00000000010110000000; // 88 degrees
//            #15 target_angle = 20'b00000000010110010000; // 89 degrees
//            #15 target_angle = 20'b00000000010110100000; // 90 degrees
                        
            #15 target_angle = 20'b00000000010110110000; // 91 degrees
            #15 target_angle = 20'b00000000010111000000; // 92 degrees
            #15 target_angle = 20'b00000000010111010000; // 93 degrees
            #15 target_angle = 20'b00000000010111100000; // 94 degrees
            #15 target_angle = 20'b00000000010111110000; // 95 degrees
            #15 target_angle = 20'b00000000011000000000; // 96 degrees
            #15 target_angle = 20'b00000000011000010000; // 97 degrees
            #15 target_angle = 20'b00000000011000100000; // 98 degrees
            #15 target_angle = 20'b00000000011000110000; // 99 degrees
            #15 target_angle = 20'b00000000011001000000; // 100 degrees
            #15 target_angle = 20'b00000000011001010000; // 101 degrees
            #15 target_angle = 20'b00000000011001100000; // 102 degrees
            #15 target_angle = 20'b00000000011001110000; // 103 degrees
            #15 target_angle = 20'b00000000011010000000; // 104 degrees
            #15 target_angle = 20'b00000000011010010000; // 105 degrees
            #15 target_angle = 20'b00000000011010100000; // 106 degrees
            #15 target_angle = 20'b00000000011010110000; // 107 degrees
            #15 target_angle = 20'b00000000011011000000; // 108 degrees
            #15 target_angle = 20'b00000000011011010000; // 109 degrees
            #15 target_angle = 20'b00000000011011100000; // 110 degrees
            #15 target_angle = 20'b00000000011011110000; // 111 degrees
            #15 target_angle = 20'b00000000011100000000; // 112 degrees
            #15 target_angle = 20'b00000000011100010000; // 113 degrees
            #15 target_angle = 20'b00000000011100100000; // 114 degrees
            #15 target_angle = 20'b00000000011100110000; // 115 degrees
            #15 target_angle = 20'b00000000011101000000; // 116 degrees
            #15 target_angle = 20'b00000000011101010000; // 117 degrees
            #15 target_angle = 20'b00000000011101100000; // 118 degrees
            #15 target_angle = 20'b00000000011101110000; // 119 degrees
            #15 target_angle = 20'b00000000011110000000; // 120 degrees
            #15 target_angle = 20'b00000000011110010000; // 121 degrees
            #15 target_angle = 20'b00000000011110100000; // 122 degrees
            #15 target_angle = 20'b00000000011110110000; // 123 degrees
            #15 target_angle = 20'b00000000011111000000; // 124 degrees
            #15 target_angle = 20'b00000000011111010000; // 125 degrees
            #15 target_angle = 20'b00000000011111100000; // 126 degrees
            #15 target_angle = 20'b00000000011111110000; // 127 degrees
            #15 target_angle = 20'b00000000100000000000; // 128 degrees
            #15 target_angle = 20'b00000000100000010000; // 129 degrees
            #15 target_angle = 20'b00000000100000100000; // 130 degrees
            #15 target_angle = 20'b00000000100000110000; // 131 degrees
            #15 target_angle = 20'b00000000100001000000; // 132 degrees
            #15 target_angle = 20'b00000000100001010000; // 133 degrees
            #15 target_angle = 20'b00000000100001100000; // 134 degrees
            #15 target_angle = 20'b00000000100001110000; // 135 degrees
            #15 target_angle = 20'b00000000100010000000; // 136 degrees
            #15 target_angle = 20'b00000000100010010000; // 137 degrees
            #15 target_angle = 20'b00000000100010100000; // 138 degrees
            #15 target_angle = 20'b00000000100010110000; // 139 degrees
            #15 target_angle = 20'b00000000100011000000; // 140 degrees
            #15 target_angle = 20'b00000000100011010000; // 141 degrees
            #15 target_angle = 20'b00000000100011100000; // 142 degrees
            #15 target_angle = 20'b00000000100011110000; // 143 degrees
            #15 target_angle = 20'b00000000100100000000; // 144 degrees
            #15 target_angle = 20'b00000000100100010000; // 145 degrees
            #15 target_angle = 20'b00000000100100100000; // 146 degrees
            #15 target_angle = 20'b00000000100100110000; // 147 degrees
            #15 target_angle = 20'b00000000100101000000; // 148 degrees
            #15 target_angle = 20'b00000000100101010000; // 149 degrees
            #15 target_angle = 20'b00000000100101100000; // 150 degrees
            
//            #15 target_angle = 20'b00000000101101000000; // 180 degrees
//            #15 target_angle = 20'b00000000101101010000; // 181 degrees
            

       #20 $finish;
     end
endmodule
