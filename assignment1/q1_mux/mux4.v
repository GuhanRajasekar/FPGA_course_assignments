module mux4(input [3:0] data, input[1:0] sel, output y);
  assign y = data[sel];  // when there is a non constant index on the RHS of the expression a latch will be inferred by the synthesis tool
endmodule
