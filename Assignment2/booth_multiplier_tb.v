module booth_multiplier_tb;
 reg    [7:0] x,y;    // Inputs in the test bench must be registers as they are given values inside the initial block
 wire   [15:0] z;     // To denote the sum of all the partial products  
 booth_multiplier a(.x(x),.y(y),.z(z));
 
 initial 
   begin
      $monitor(" time =%d , x = %b , y = %b, z = %b",$time,x,y,z);
      #5  x = 8'b11010011; y = 8'b00001001;
      #10 $finish;
   end

endmodule
