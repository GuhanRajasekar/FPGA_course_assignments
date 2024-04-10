`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2023 18:49:35
// Design Name: 
// Module Name: waveform_generator
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


module waveform_generator(
    input clk,
    input [15:0] frequency,
    input reset,
    output wire [7:0] sine,
    output wire [7:0] cosine
    );
    
    reg [7:0]xin = 8'd75;
    reg [7:0]yin = 8'd0;
    wire [31:0] wangle;
    angle_generator ag1(.reset(reset),.clk(clk),.frequency(frequency),.angle(wangle));
    sine_cosine_generator scg1(.clock(clk), .angle(wangle), .Xin(xin), .Yin(yin), .Xout(sine), .Yout(cosine));
endmodule
