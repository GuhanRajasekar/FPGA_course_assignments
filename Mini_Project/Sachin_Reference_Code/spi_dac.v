`timescale 1ns / 1ps

module spi_dac(
input clk_in,rst,start,
input [11:0] datain,
output reg data,cs,
output sclk
    );

reg [4:0] count = 5'd0;
reg [11:0] data_in_reg;
parameter s0 = 2'b00;   // Idle state
parameter s1 = 2'b01;   // Register state
parameter s2 = 2'b11;   // 
reg [1:0] pr_state, nx_state;
wire max;
reg crst;

always @(posedge clk_in)
begin
if (rst == 1) 
pr_state <= s0; 
else  
pr_state <= nx_state;  // Computation of nx_state is done in a combinational always block
end


// The combinational always block is used to determine nx_state
always @(pr_state, start, max) begin
            case (pr_state)
            s0: begin //Idle state
                crst <= 1'b1;
                cs <= 1'b1; //DC
                if (start) begin
                    nx_state <= s1;   // If start is high, then go to next state s1
                end
                else begin
                    nx_state <= s0;   // If start is low, then stay in the same state
                end
            end
            
            s1: begin //Register data
                crst <= 1'b1;
                cs <= 1'b1; //DC
                data_in_reg <= datain;
                nx_state <= s2;
            end
            
            s2: begin
                crst <= 1'b0;
                cs <= 1'b0; //DC
                if (max) begin           // Once 16 bits are filled, go to idle state
                    nx_state <= s0;
                end
                else begin               // If 16 bits are not filled, stay in state s2.
                    nx_state <= s2;
                end
            end
            
            default: begin
                crst <= 1'b1;
                cs <= 1'b1; //DC
                nx_state <= s0;
            end
        endcase
    
end


always @(posedge clk_in) begin
    if (crst == 1) begin
        count <= 0;
    end else begin
        count <= count + 1;
        case(count)
            0: data <= 1'b0; //DC
            1: data <= 1'b0; //DC
            2: data <= 1'b0; //0 for Normal operation
            3: data <= 1'b0; //0 for Normal operation
            4: data <= datain[11]; // MSB bit goes out first
            5: data <= datain[10];
            6: data <= datain[9];
            7: data <= datain[8];
            8: data <= datain[7];
            9: data <= datain[6];
            10: data <= datain[5];
            11: data <= datain[4];
            12: data <= datain[3];
            13: data <= datain[2];
            14: data <= datain[1];
            15: data <= datain[0];
            default: data <= 1'b0;
        endcase
    end
end

assign max = (count == 5'd16) ? 1'b1:1'b0;
assign sclk = clk_in;

endmodule

