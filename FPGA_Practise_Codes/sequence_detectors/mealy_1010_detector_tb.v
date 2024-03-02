module seq_detector_tb;
  reg x,clk,rst;
  wire y;
  wire [1:0] curr_state;
  
  seq_detector m(.x(x) , .clk(clk) , .rst(rst) , .y(y) , .curr_state(curr_state) );
  
  always #2.5 clk = ~clk;  // To keep toggling the clock for every 2 ns
  
  initial
    begin
      #0 clk = 0; rst = 0;x = 0;
      #5 rst = 1; x = 1;
      #5 x = 0;
      #5 x = 1;
      #5 x = 0;
      #5 x = 1;
      #5 x = 0;
      #5 x = 1;
      #5 x = 0;
      #5 x = 1;
      #5 x = 1;
      #5 x = 0;
      #5 x = 0;
      #5 x = 0;
      #5 x = 1;
      #5 x = 0;
      #5 x = 1;
      #5 x = 0;
      #5 x = 1;
      #5 x = 0;
      #5 x = 0; 
      #5 $finish;
    end
  
endmodule