`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2023 10:41:07
// Design Name: 
// Module Name: interface_wg_dac
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


module interface_wg_dac(
    input rst,
    input [7:0] sine,
    input [7:0] cosine,
    output reg pulse,
    input clk,
    output reg [15:0] out_sine,
    output reg [15:0] out_cosine
    );
    reg [9:0] count;
    wire [15:0] imsine;
    wire [15:0] imcosine;
    assign imsine = {4'b0000,sine,4'b0000};
    assign imcosine = {4'b0000,cosine,4'b0000};

always @(posedge clk) begin
    if(rst==1) begin
    count<=10'd0;
    pulse<=1;
    end
    else if (count < 35) begin
        pulse <= 1'b1;
        count <= count + 1;
        out_sine<=imsine;
        out_cosine<=imcosine;
    end else if (count < 100) begin
        pulse <= 1'b0;
        count <= count + 1;
    end else begin
        count <= 6'd0;
    end
end 
endmodule
