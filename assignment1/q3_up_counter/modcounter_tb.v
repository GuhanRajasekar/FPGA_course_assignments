module modcounter_tb;
  reg clk,rst;
  reg [2:0] ctrl;
  reg [3:0] data;
  wire [3:0] count;
  modcounter m1(.clk(clk), .rst(rst), .ctrl(ctrl), .data(data), .count(count));
  always #2 clk = ~clk;
  
  initial 
    begin
       $dumpfile("modcounter_waveforms.vcd");
       $dumpvars(0,modcounter_tb);
       clk = 1'b0;
       $monitor($time," rst = %b, ctrl = %b,count = %b ",rst,ctrl,count);
       #5   rst = 1'b1; ctrl = 3'b000 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b001 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b001 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b001 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b011 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b011 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b011 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b011 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b011 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b011 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b011 ; data = 4'h4;
       #5   rst = 1'b1; ctrl = 3'b010 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b010 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b010 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b011 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b011 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b011 ; data = 4'h4;
       #5   rst = 1'b0; ctrl = 3'b011 ; data = 4'h4;
       #5   $finish;
    end
endmodule
