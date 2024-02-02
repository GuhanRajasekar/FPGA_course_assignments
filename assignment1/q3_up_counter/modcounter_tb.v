`timescale 10ns/10ps
module modcounter_tb;
  reg clk,rst;
  reg [2:0] ctrl;
  reg [3:0] data;
  wire [3:0] count;
  wire [15:0] t_count;
  modcounter #(.N(10)) m1(.clk(clk),.rst(rst), .ctrl(ctrl), .data(data), .count(count) ,.t_count(t_count));
  always #2   clk  = ~clk;
  
  initial 
    begin
       $dumpfile("modcounter_waveforms.vcd");
       $dumpvars(0,modcounter_tb);
       $monitor($time," rst = %b, ctrl = %b,count = %b ",rst,ctrl,count);
       #0 clk  = 1'b1; rst  = 1'b0;  ctrl = 3'b000 ;data = 4'h4;        
       #5   rst = 1'b0; ctrl = 3'b000 ; data = 4'h4;
       #5   rst = 1'b1; ctrl = 3'b000 ; data = 4'h4;
       #5   rst = 1'b1; ctrl = 3'b000 ; data = 4'h4;
       #5   rst = 1'b1; ctrl = 3'b010 ; data = 4'h4;
       #5   rst = 1'b1; ctrl = 3'b010 ; data = 4'h4;
       #5   rst = 1'b1; ctrl = 3'b001 ; data = 4'h4;
       #5   rst = 1'b1; ctrl = 3'b001 ; data = 4'h5;
       #5   rst = 1'b1; ctrl = 3'b010 ; data = 4'h2;
       #5   rst = 1'b1; ctrl = 3'b010 ; data = 4'h1;
       #5   rst = 1'b1; ctrl = 3'b000 ; data = 4'h5;
       #5   rst = 1'b1; ctrl = 3'b010 ; data = 4'h5;
       #5   rst = 1'b1; ctrl = 3'b010 ; data = 4'h4;
       #5   rst = 1'b1; ctrl = 3'b010 ; data = 4'h4;
       #5   rst = 1'b1; ctrl = 3'b011 ; data = 4'h4;
       #5   rst = 1'b1; ctrl = 3'b010 ; data = 4'h4;
       #5   $finish;
    end
endmodule
