module mux_tb_juice;
  reg [3:0] data;
  reg [1:0] sel;
  wire y;
  mux4 m1(.data(data),.sel(sel),.y(y));
  initial
    begin
      $monitor($time," data=%b, sel=%b, y=%b ",data,sel,y);
      #10 data=4'b0000; sel=2'b00; 
      #10 data=4'b0001; sel=2'b01; 
      #10 data=4'b0010; sel=2'b10; 
      #10 data=4'b0011; sel=2'b11;
      #10 data=4'b0100; sel=2'b10; 
      #10 data=4'b0101; sel=2'b01; 
      #10 data=4'b0110; sel=2'b00; 
      #10 data=4'b0111; sel=2'b00; 
      #10 data=4'b1000; sel=2'b11;
      #10 data=4'b1001; sel=2'b10; 
      #10 data=4'b1010; sel=2'b01; 
      #10 data=4'b1011; sel=2'b10;  
      #10 $finish; 
    end
endmodule
