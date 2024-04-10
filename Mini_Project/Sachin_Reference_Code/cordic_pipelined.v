`timescale 1ns / 1ps

module cordic_pipelined(
input Clock,Reset,
input signed [11:0] X,Y,Z,
output signed [11:0] X_result,Y_result,Z_result
    );
    
    
reg [11:0] ATAN_TABLE [0:11];   
reg signed [11:0] x_pl [1:12];   
reg signed [11:0] y_pl [1:12];  
reg signed [11:0] z_pl [1:12];  
reg signed [11:0] x_array [0:12];   
reg signed [11:0] y_array [0:12];  
reg signed [11:0] z_array [0:12];    
reg negative;
    
  initial begin
        ATAN_TABLE[0] = 12'h200;  // 512
        ATAN_TABLE[1] = 12'h12e;  // 302
        ATAN_TABLE[2] = 12'h0a0;  // 160
        ATAN_TABLE[3] = 12'h051;  // 81
        ATAN_TABLE[4] = 12'h029;  // 41
        ATAN_TABLE[5] = 12'h014;  // 20
        ATAN_TABLE[6] = 12'h00a;  // 10
        ATAN_TABLE[7] = 12'h005;  // 5
        ATAN_TABLE[8] = 12'h003;  // 3
        ATAN_TABLE[9] = 12'h001;  // 1
        ATAN_TABLE[10] = 12'h001; // 1
        ATAN_TABLE[11] = 12'h000; // 0
    end    
    
integer i;

always @*
begin
x_array[0] = X;   // Initialization value for X is sent from module sincos_pipelined
y_array[0] = Y;   // Initialization value for Y is sent from module sincos_pipelined
z_array[0] = Z;   // Initialization value for Z is sent from module sincos_pipelined
  for (i = 1; i <= 12; i = i + 1) begin
    x_array[i] = x_pl[i];    // x_pl is computed in a sequential always block
    y_array[i] = y_pl[i];    // y_pl is computed in a sequential always block
    z_array[i] = z_pl[i];    // z_pl is computed in a sequential always block
    end
end


// Here Clock is the natural 10MHz clock of FPGA
 always @(posedge Clock) begin
    if (Reset) begin
        // Here we reset all the registers
    for (i = 1; i <= 12; i = i + 1) begin
      x_pl[i] = 12'h000;   
      y_pl[i] = 12'h000;
      z_pl[i] = 12'h000;
     end
    end

    // If not reset , we do the following 12 iterations to compute sin and cos of given angle
    else begin
        for (i = 1; i <= 12; i = i + 1) begin
            negative = (z_array[i-1][11] == 1'b1);

            if (negative) begin
                x_pl[i] <= x_array[i-1] + (y_array[i-1] / (1 << (i-1)));
                y_pl[i] <= y_array[i-1] - (x_array[i-1] / (1 << (i-1)));
                z_pl[i] <= z_array[i-1] + ATAN_TABLE[i-1];
            end
            else begin
                x_pl[i] <= x_array[i-1] - (y_array[i-1] / (1 << (i-1)));
                y_pl[i] <= y_array[i-1] + (x_array[i-1] / (1 << (i-1)));
                z_pl[i] <= z_array[i-1] - ATAN_TABLE[i-1];
            end
        end
    end
end
 
    
assign X_result = x_array[12];
assign Y_result = y_array[12];
assign Z_result = z_array[12];
   
endmodule
