`timescale 1ns/1ps
module sr_latch(s,r,rst,clk,q,q_bar);
  input s,r,rst,clk;
  output reg q,q_bar;
  
  reg q_store;  // Temporary register to hold the value of q
  
  
  // To store the previous value of q (This will be used to implement hold condition)
  always@(posedge clk)
     begin
       if(rst == 0) q_store <= 0;
       else         q_store <= q;   // This will be used to implement hold condition
     end
   
  always@(*)  q_bar = ~q;
    
  always@(*)
     begin
        if(rst == 0) q = 1'b0;
        else 
          begin
             if     (s == 0 && r == 1)      q = 1'b0    ;  // reset condition
             else if(s == 1 && r == 0 )     q = 1'b1    ;  // set condition
             else                           q = q_store ;  // hold condition (We use q_store here to avoid combinatorial loop detected violation)
          end
     end
endmodule
