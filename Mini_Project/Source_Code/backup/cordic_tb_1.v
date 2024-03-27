`timescale 1ns / 1ps

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
       
       // Positive angle values
//       #5 target_angle = 20'b00000000001110101000;  // 58.54 degrees
//       #5 target_angle = 20'b00000000000111110101;  // 31.33 degrees
//       #5 target_angle = 20'b00000000010000110001;  // 67.12 degrees
//       #5 target_angle = 20'b00000000000011001011;  // 12.689 degrees
//       #5 target_angle = 20'b00000000000000000000;  // 0 degrees
//       #5 target_angle = 20'b00000000010110100000;  // 90 degrees
       
       // Negative of the angles above - 4th quadrant
//       #5 target_angle = 20'b11111111110001011000;  // 58.54 degrees
//       #5 target_angle = 20'b11111111111000001011;  // 31.33 degrees
//       #5 target_angle = 20'b11111111101111001111;  // 67.12 degrees
//       #5 target_angle = 20'b11111111111100110101;  // 12.689 degrees
//       #5 target_angle = 20'b00000000000000000000;  // 0 degrees
//       #5 target_angle = 20'b11111111101001100000;  // 90 degrees
       
       // 2nd quadrant
       #10 target_angle = 20'b00000000100101001000;  // 90 + 58.54 degrees
       #10 target_angle = 20'b00000000011110010101;  // 90 + 31.33 degrees
       #10 target_angle = 20'b00000000100111010001;  // 90 + 67.12 degrees
       #10 target_angle = 20'b00000000011001101011;  // 90 + 12.689 degrees
       #10 target_angle = 20'b00000000010110100000;  // 90 + 0 degrees
       #10 target_angle = 20'b00000000101101000000;  // 90 + 90 degrees

       #20 $finish;
     end
endmodule
