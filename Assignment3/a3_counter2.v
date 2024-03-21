`timescale 1s/10ps
module modcounter #(parameter N = 16)(clk,clk2,rst,ctrl,data,t_count);
  input clk,clk2,rst;
  input [2:0] ctrl;                 // to decide what the counter must do
  input [3:0] data;                 // To store the value that must be 'loaded' into the counter
  output reg [15:0] t_count;        // register variable to give thermometric count for better visualization
  
  
  reg[3:0] count;                   // Register variable that stores the current count value
  reg [26:0] clk2count_comb;        // counter used in combinational always block to count to downscale the clock signal
  reg [26:0] clk2count_clk;         // count   used in clocked always block to count to downscale the clock signal
  
  reg flag_clk;                     // flag that is updated in the clocked always block
  reg flag_comb;                    // flag that is updated in the combinational always block
  reg[3:0] count_next;              // Intermediate register variable that stores the next value of the count
  
  reg syn1, syn2;    // Register variables to implement the two stage synchronizer
  reg debounce_flag; // register variable to check if synchronizer output is stable after passing through the debouncer circuit

// clk2 is an asynchronous input that comes from button press
// two stage synchronizer for clk2
always@(posedge clk)
  begin
    if(rst == 0)
       begin
         syn1 <= 0;
         syn2 <= 0;
       end 
    else
       begin
         syn1 <= clk2;
         syn2 <= syn1;
       end
  end

//debouncing circuit
always@(*)
  begin
    if(syn2 == 1) clk2count_comb = clk2count_clk + 1; // increment the count
    else clk2count_comb = 0; // reset the count value when syn2 is low
  end

// combinational always block to set the status of the debounce flag based on the value of the synchronizer output
always@(*)
    if(clk2count_comb == 2000000) debounce_flag = (syn2==1) ? 1 : 0;
    else                          debounce_flag = 0;

// Updating the count value of the saturating counter of 20ms
always@(posedge clk)
 begin
  if(rst == 0) clk2count_clk <= 0;
  else         clk2count_clk <= clk2count_comb;   
 end
 
//sequential always block to take care of updating the count value using the output of the debouncer circuit
always@(posedge clk)
  begin
      if(rst == 0)
        begin
          flag_clk <= 0;
          count    <= 0; 
        end
      else
        begin
         if(debounce_flag == 1)
           begin
             flag_clk <= flag_comb; 
             count    <= count_next;
           end
           else 
            begin
              flag_clk <= flag_clk;
              count   <= count;
            end
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
         3: count_next = (data < N) ? data : 0;                              // ctrl = 3 => Load Data
         default: count_next = count;                                        // ctrl = 4,5,6,7 => Hold the data 
       endcase
    end

   always@(*)
     begin
       case(count)
        0: t_count = 0;
        1: t_count = 1;   // 0000 0000 0000 0001 => 1
        2: t_count = 3;   // 0000 0000 0000 0011 => 3
        3: t_count = 7;   // 0000 0000 0000 0111 => 7
        4: t_count = 15;  // 0000 0000 0000 1111 => 15
        5: t_count = 31;  // 0000 0000 0001 1111 => 1F
        6: t_count = 63;  // 0000 0000 0011 1111 => 3F
        7: t_count = 127; // 0000 0000 0111 1111 => 7F
        8: t_count = 255; // 0000 0000 1111 1111 => FF
        9: t_count = 511;  // 0000 0001 1111 1111 => 1FF
        10: t_count = 1023; // 0000 0011 1111 1111 => 3FF
        11: t_count = 2047; // 0000 0111 1111 1111 => 7FF
        12: t_count = 4095; // 0000 1111 1111 1111 => FFF
        13: t_count = 8191; // 0001 1111 1111 1111 => 1FFF
        14: t_count = 16383; // 0011 1111 1111 1111  => 3FFF
        15: t_count = 32767; // 0111 1111 1111 1111 => 7FFF
        default : t_count = 0; 
      endcase
    end
endmodule