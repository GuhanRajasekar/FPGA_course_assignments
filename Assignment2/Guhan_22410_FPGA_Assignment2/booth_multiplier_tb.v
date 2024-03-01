`timescale 1ns/1ps
module booth_multiplier_tb;
 reg    [7:0] x,y;    // Inputs in the test bench must be registers as they are given values inside the initial block
 reg    clk, rst;     // Register inputs for clock and reset
 wire   [15:0] result;     // To denote the sum of all the partial products  
 wire   carry;
 booth_multiplier a(.x(x),.y(y),.clk(clk),.rst(rst),.result(result),.carry(carry));
 
 always 
    begin
       #2 clk = ~clk;
    end
 initial 
   begin
      # 0 clk = 1'b0;  rst = 1'b0;
      $monitor(" time =%d , x = %b , y = %b, result = %b , carry = %b",$time,x,y,result,carry);
      #100  rst = 1'b1; x = 8'b11111111; y = 8'b10000000;
      #100  rst = 1'b1; x = 8'b10111111; y = 8'b10000000;
      #100  rst = 1'b1; x = 8'b11011111; y = 8'b01100000;
      #100  rst = 1'b1; x = 8'b11101101; y = 8'b00010000;
      #100  rst = 1'b1; x = 8'b01110111; y = 8'b01100000;
      #100  rst = 1'b1; x = 8'b10001111; y = 8'b10001000;
      #100 $finish;
   end

endmodule
