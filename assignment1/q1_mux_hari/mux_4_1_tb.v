`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2024 03:27:01 PM
// Design Name: 
// Module Name: TB_mux_4_1
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


module TB_mux_4_1();
reg [3:0] d0,d1,d2,d3;
reg [1:0] sel;
wire [3:0] Y;
mux_4_1 DUT(.sel(sel),.d0(d0),.d1(d1),.d2(d2),.d3(d3),.Y(Y));

initial
    begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end
initial
    begin
       d0 = 4'b0001;
       d1 = 4'b0010;
       d2 = 4'b0100;
       d3 = 4'b1000;
       #5 sel = 2'b00;
       #5 sel = 2'b01;
       #5 sel = 2'b10;
       #5 sel = 2'b11;
       #5 $finish;      
    end
endmodule
