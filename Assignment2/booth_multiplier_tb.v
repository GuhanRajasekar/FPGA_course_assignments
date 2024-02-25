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
      #1  rst = 1'b1; x = 8'b00001101; y = 8'b10010111;
      #10 $finish;
   end

endmodule
