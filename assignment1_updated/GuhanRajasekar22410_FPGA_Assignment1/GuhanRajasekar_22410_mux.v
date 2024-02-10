module mux4(input [15:0] data, input[1:0] sel, output [3:0]y);
  // Data flow style of modelling to implement a 16 bit wide 4:1 MUX
  assign y[3:0] = {data[3+(sel*4)],data[2+(sel*4)],data[1+(sel*4)],data[0+(sel*4)]};
endmodule