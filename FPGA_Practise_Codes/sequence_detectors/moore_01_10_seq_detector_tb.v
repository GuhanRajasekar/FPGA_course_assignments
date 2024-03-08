module moore_01_10_seq_detector_tb;
  reg x , clk , rst;
  wire [4:0]curr_state;
  wire y;
  
  moore_01_10_seq_detector m(.x(x) , .clk(clk), .rst(rst),.curr_state(curr_state),.y(y));
  
  always #2 clk = ~clk;
  
  initial 
    begin
      #0 rst = 1'b0; clk = 1'b1; x = 1'b0;
      #1 rst = 1'b1;
      #5 x = 1'b0;
      #5 x = 1'b0;
      #5 x = 1'b1;
      #5 x = 1'b0;
      #5 x = 1'b1;
      #5 x = 1'b0;
      #5 x = 1'b1;
      #5 x = 1'b1;
      #5 x = 1'b0;
      #5 x = 1'b0;
      #5 x = 1'b1;
      #5 x = 1'b0;
      #5 x = 1'b1;
      #5 x = 1'b0;
      #5 x = 1'b1;   
      #5 $finish;   
    end
endmodule