// This code first produces the mealy outputs
// It then registers the  outputs to get moore behaviour

module moore_mealy_01_10_seq_detector(x,clk,rst,curr_state,y_mealy,y_moore);
 input x,clk,rst; 
 output reg y_mealy;  // The output in FSM (Moore or Mealy) needs to be updated in a clocked always block
 output reg y_moore;
 output reg [2:0] curr_state; // packed dimensions will appear before the name of the vector of reg data type 
 
 reg [2:0] next_state; // next_state will be computed in the combinational always block
 
 always@(posedge clk)
   begin
      if(rst == 0)
       begin
          curr_state <= 3'b001;
          y_moore    <= 1'b0;
       end
      else  
        begin       
          curr_state <= next_state;
          y_moore    <= y_mealy;
        end
   end

always@(*)
   begin
      case(curr_state)
        3'b001:                    // Reset Case
           begin
             y_mealy = 1'b0;
             next_state = (x==0) ? 3'b010 : 3'b100;
           end
        3'b010:
           begin
             y_mealy = (x == 0) ? 1'b0 : 1'b1; 
             next_state = (x==0) ? 3'b010 : 3'b100;  
           end
        3'b100:
           begin
             y_mealy = (x == 0) ? 1'b1 : 1'b0;
             next_state = (x==0) ? 3'b010 : 3'b100;
           end
        default:
           begin
             y_mealy = 1'b0;             // reset the output to 0
             next_state = 3'b001;  //reset
           end
      endcase
   end

endmodule