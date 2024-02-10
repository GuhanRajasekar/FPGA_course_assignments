module cla_testbench;
                  // No need to declare the variables as input and output in test benches because they just provide stiumulus and monitor the outputs of the DUT
  reg [3:0] a,b;  // stimulus to DUT must be given through registers as they are initialized in "initial" block
  reg cin;       
  wire [3:0]so;
  wire co;
  
  cla m1(.a(a),.b(b),.cin(cin),.so(so),.co(co));
  initial
    begin
      $dumpfile ("cla_waveforms.vcd");
      $dumpvars (0,cla_testbench);
      $monitor($time, " a=%b,b=%b,cin=%b, s=%b,co=%b ",a,b,cin,so,co);
      #0 a = 1; b = 7;  cin = 1;
      #5 a = 0; b = 2;  cin = 0;
      #5 a = 1; b = 3;  cin = 1;
      #5 a = 5; b = 10; cin = 0;
      #5 a = 5; b = 10; cin = 1;
      #5 $finish;
    end
endmodule
