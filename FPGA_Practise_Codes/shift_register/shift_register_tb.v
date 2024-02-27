module shift_register_tb;
reg data,clk,rst;  // Inputs to be given to DUT are declared as registers as they will be initialized values in "initial" blocks
wire [3:0]result;  // These wires will be continuously driven by the output of DUT

shift_register G(.data(data) , .clk(clk) , .rst(rst) , .result(result));  // Module Instantiation

always #2 clk = ~clk;

initial 
  begin
    $monitor ("Time=%d, data = %b, result = %b ",$time,data,result);
    $dumpfile("shift_register_simulation.vcd");
    $dumpvars(0,shift_register_tb);
    #0  clk  = 1'b1; rst  = 1'b0; data = 1'b0 ;
    #2  rst  = 1'b1;
    #5  data = 1'b1;
    #10 data = 1'b0;
    #50 $finish;
  end
endmodule
