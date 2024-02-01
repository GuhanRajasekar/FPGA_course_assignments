`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2024 03:11:04 PM
// Design Name: 
// Module Name: mux_4_1
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


module mux_4_1(
input wire [1:0] sel,
input wire [3:0] d0,d1,d2,d3,
output reg [3:0] Y
    );
    always @(*)
        begin
            case(sel)
                2'b00: Y = d0;
                2'b01: Y = d1;
                2'b10: Y = d2;
                2'b11: Y = d3;
            endcase
        end
endmodule