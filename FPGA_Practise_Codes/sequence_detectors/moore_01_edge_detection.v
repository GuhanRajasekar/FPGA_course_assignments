// Code for 0->1 edge detection using Moore FSM
// Use the same testbench that has been used for other FSM codes (Just set the size of curr_state variable properly)

module moore_01_edge_detector(clk,rst,x,curr_state,y);
 input x,clk,rst; 
 output reg y;  // The output in FSM (Moore or Mealy) needs to be updated in a clocked always block
 output reg [1:0] curr_state; // packed dimensions will appear before the name of the vector of reg data type
 
 reg [1:0] next_state;
 always@(posedge clk)
   begin
     if(rst == 0) curr_state <= 2'b00;
     else         curr_state <= next_state;
   end
   
always@(*)
   begin
     case(curr_state)
       2'b00:
          begin
             y          = 1'b0;
             next_state = (x == 0) ? 2'b00 : 2'b01; 
          end
          
       2'b01:
          begin
             y          = 1'b1;
             next_state = (x == 0) ? 2'b00 : 2'b10; 
          end
       
       2'b10:
          begin
             y          = 1'b0;
             next_state = (x == 0) ? 2'b00 : 2'b10; 
          end 

       default:
          begin
             y          = 1'b0;
             next_state = (x == 0) ? 2'b00 : 2'b01; 
          end
         
     endcase
   end
 
 

endmodule