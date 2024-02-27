module sr_latch_tb;
reg s,r,rst,clk;
wire q,q_bar;
sr_latch G(.s(s) , .r(r) , .rst(rst) , .clk(clk) , .q(q) , .q_bar(q_bar));

always #2 clk = ~clk;

initial
  begin
   $monitor("Time = %d, s = %b , r = %b , q=%b , q_bar = %b",$time, s,r,q,q_bar);
   $dumpfile("sr_latch_results.vcd");
   $dumpvars(0 , sr_latch_tb);
   #0 clk = 0; rst = 0; s= 0; r = 0;
   #5 rst = 1; s = 1; r = 0;
   #5 rst = 1; s = 0; r = 1;
   #5 rst = 1; s = 0; r = 0;
   #5 $finish;
  end

endmodule
