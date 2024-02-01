`timescale 10ns/10ps
module modcounter(clk,rst,ctrl,data,count);
  input clk,rst;
  input [2:0] ctrl;               // to decide what the counter must do
  input [3:0] data;               // To store the value that must be 'loaded' into the counter
  output reg [3:0] count;         // Outpur register variable that stores the current count value
//  reg clk2;                       // scaled down version of the clock signal
//  reg [27:0] clk2_count;          // register to count the values to scale down the clock signal
  reg flag_clk;                   // flag that is updated in the clocked always block
  reg flag_comb;                  // flag that is updated in the combinational always block
  reg[3:0] count_next;            // Intermediate register variable that stores the next value of the count
  parameter N = 7;                // N can go up to 16 

always@(posedge clk)
  begin
    if(rst == 0) 
      begin
        flag_clk <= 0;   // flag_clk = 0 indicates up counting
        count    <= 0;
      end
    else
      begin
        flag_clk <= flag_comb;
        count    <= count_next;
      end  
  end


// always block to take care of flag updation
always@(*)
  begin
   if(ctrl == 2)
     begin
        if      ((flag_clk == 0) && (count == N-1)) flag_comb = 1;  // start down counting as max count has been reached
        else if ((flag_clk == 1) && (count == 0))   flag_comb = 0;  // start up counting as min count has been reached
        else      flag_comb = flag_clk;                             // Retain the previous state of the flag for intermediate values
     end
   else flag_comb = 0;
  end

// Count generation block (Done within a combinational always block)
// Recommended to use blocking assignments inside a combinational always block
  always@(*)
    begin
       case(ctrl)                                                       
         0: count_next = (count == N-1) ? 0 : (count + 1);                   // ctrl = 0 => Up Count
         1: count_next = (count == 0)? (N-1): (count-1);                     // ctrl = 1 => Down Count
         2: count_next = (flag_comb == 0) ? (count + 1) : (count - 1);       // ctrl = 2 => Up/Down count
         3: count_next = data;                                               // ctrl = 3 => Load Data
         default: count_next = count;                                        // ctrl = 4,5,6,7 => Hold the data 
       endcase
    end
endmodule
