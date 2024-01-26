module modcounter_tb;
  reg clk;
  reg [2:0] ctrl;
  reg [3:0] data;
  wire [3:0] count;
  modcounter m1(.clk(clk), .ctrl(ctrl), .data(data), .count(count));
  always #2 clk = ~clk;
  
  initial 
    begin
       $dumpfile("modcounter_waveforms.vcd");
       $dumpvars(0,modcounter_tb);
       clk = 1'b0;
       $monitor($time," ctrl = %b,count = %b ",ctrl,count);
       #5   ctrl = 3'b000 ; data = 4'h4;
       #5   ctrl = 3'b010 ; data = 4'h4;
       #5   ctrl = 3'b010 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   ctrl = 3'b100 ; data = 4'h4;
       #5   $finish;
    end
endmodule
