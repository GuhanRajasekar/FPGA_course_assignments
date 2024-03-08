module moore_01_10_seq_detector(x,clk,rst,curr_state,y);
 input x,clk,rst; 
 output reg y;  // The output in FSM (Moore or Mealy) needs to be updated in a clocked always block
 output reg [4:0] curr_state; // packed dimensions will appear before the name of the vector of reg data type 
 
 reg [4:0] next_state; // next_state will be computed in the combinational always block
 
 always@(posedge clk)
   begin
      if(rst == 0) curr_state <= 5'b00001;
      else         curr_state <= next_state;
   end
 
 always@(*)
   begin
      case(curr_state)
        5'b00001:     // Reset State
            begin
               y = 1'b0;
               next_state = (x == 0) ? 5'b00010 : 5'b00100;
            end
        
        5'b00010:
            begin
               y = 1'b0;
               next_state = (x == 0) ? 5'b00010 : 5'b01000;
            end
        5'b00100:
             begin
               y = 1'b0;
               next_state = (x == 0) ? 5'b10000 : 5'b00100;
             end
        5'b01000:
             begin
               y = 1'b1;
               next_state = (x == 0) ? 5'b10000 : 5'b00100;
             end
        5'b10000:
             begin
               y = 1'b1;
               next_state = (x == 0) ? 5'b00010 : 5'b01000;
             end
        default:
             begin
               y = 1'b0;
               next_state = 5'b00001;  // Reset Condition
             end
      endcase     
   end
endmodule