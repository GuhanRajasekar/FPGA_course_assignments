`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2023 21:40:10
// Design Name: 
// Module Name: pmodDAC
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


module pmodDAC(
    input clock100Mhz,
    input [15:0] sine_data,
    input [15:0] cosine_data,
    input  rst,
    output reg SCLK,
    output reg SDATA1,
    output reg SDATA2,
    output reg NSYNC
    );

reg[15:0] temp_SDATA1,temp_SDATA2;
reg[6:0] counter=10'd0;
parameter DIVISOR = 4'd4;

always @(posedge clock100Mhz)
begin
    if(rst)
        begin
            counter <=4'd0;
            SCLK<=0;
            SDATA1<=0;
            SDATA2<=0;
            NSYNC <=1;
            temp_SDATA1<=0;   
            temp_SDATA2<=0;
        end
    else
        begin
            if(counter < 10'd64)
                begin
                    SCLK<=0;
                    SDATA1<=0;
                    SDATA2<=0;
                    NSYNC <=1; 
                    temp_SDATA1<=sine_data;   
                    temp_SDATA2<=cosine_data;
                end
        end
    if(counter>10'd63)
        begin
            NSYNC <=0; 
            if(counter[0])
                begin
                    SCLK <= ~SCLK;
                end
            if(counter[1:0])
                begin
                   SDATA1<=temp_SDATA1[15-((counter-64)/DIVISOR)];
                   SDATA2<=temp_SDATA2[15-((counter-64)/DIVISOR)]; 
                end    
        end
        counter <= counter + 4'd1;
end 
endmodule


