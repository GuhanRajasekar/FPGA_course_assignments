`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 19:30:06
// Design Name: 
// Module Name: cordic_tanh
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

// For tanh the inputs and outputs have the resolution of 10 bits for the integer part and 10 bits for the fractional part

module cordic_tanh(clk, rst, target_angle, tanh);
input clk,rst; 
input signed[19:0] target_angle;

output wire signed [19:0] tanh;

//wire signed [19:0] tanh1;  // temporary variable to store the result

wire signed [19:0] cosh, sinh;

cordic_sinh_cosh tanh1 (.clk(clk), .rst(rst), .target_angle(target_angle), .x_res(cosh), .y_res(sinh));
cordic_division  tanh2(.clk(clk), .rst(rst), .x_input(cosh), .y_input(sinh), .z_res(tanh));


//always@(*)
//  begin
//     if     (target_angle >= 20'b00000000010000000000)  tanh = 20'b00000000010000000000;
//     else if(target_angle <= 20'b11111111110000000000 ) tanh = 20'b11111111110000000000;
//     else                                               tanh = tanh1;
//  end


endmodule
