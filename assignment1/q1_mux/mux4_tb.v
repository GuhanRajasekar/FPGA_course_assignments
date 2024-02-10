module mux_tb;
  reg [15:0] data;
  reg [1:0] sel;
  wire [3:0]y;
  mux4 m1(.data(data),.sel(sel),.y(y));
  initial
    begin
      $monitor($time," data=%b, sel=%b, y=%b ",data,sel,y);
      # 0 data=16'h000a; sel=2'b00; 
      #10 data=16'h00ab; sel=2'b01; 
      #10 data=16'hc01d; sel=2'b10; 
      #10 data=16'hef11; sel=2'b11;
      #10 data=16'ha1f0; sel=2'b10; 
      #10 data=16'hb101; sel=2'b01; 
      #10 data=16'hc110; sel=2'b00; 
      #10 data=16'h01d1; sel=2'b00; 
      #10 data=16'hf0f0; sel=2'b11;
      #10 data=16'h1011; sel=2'b10;  
      #10 $finish; 
    end
endmodule
