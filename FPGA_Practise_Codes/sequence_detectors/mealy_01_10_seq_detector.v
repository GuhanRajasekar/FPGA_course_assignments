// We can see the output transitions properly only when there is some delay between the 0->1 / 1->0 edge and the next active edge of the clock
// If the 0->1 / 1->0 transition and the active clock edge appear at the exact same time, then output does not change

module mealy_01_10_seq_detector(x,clk,rst,curr_state,y);
 input x,clk,rst; 
 output reg y;  // The output in FSM (Moore or Mealy) needs to be updated in a clocked always block
 output reg [2:0] curr_state; // packed dimensions will appear before the name of the vector of reg data type 
 
 reg [2:0] next_state; // next_state will be computed in the combinational always block
 
 always@(posedge clk)
   begin
      if(rst == 0) curr_state <= 3'b001;
      else         curr_state <= next_state;
   end

always@(*)
   begin
      case(curr_state)
        3'b001:                    // Reset Case
           begin
             y = 1'b0;
             next_state = (x==0) ? 3'b010 : 3'b100;
           end
        3'b010:
           begin
             y = (x == 0) ? 1'b0 : 1'b1; 
             next_state = (x==0) ? 3'b010 : 3'b100;  
           end
        3'b100:
           begin
             y = (x == 0) ? 1'b1 : 1'b0;
             next_state = (x==0) ? 3'b010 : 3'b100;
           end
        default:
           begin
             y = 1'b0;             // reset the output to 0
             next_state = 3'b001;  //reset
           end
      endcase
   end

endmodule