module modcounter(clk,rst,ctrl,data,count);
  input clk,rst;
  input [2:0] ctrl;               // to decide what the counter must do
  input [3:0] data;               // To store the value that must be 'loaded' into the counter
  output reg [3:0] count;         // Outpur register variable that stores the current count value
  reg flag;                       // flag = 0 / 1 indicates up count / down count
  reg[3:0] count_next;            // Intermediate register variable that stores the next value of the count
  parameter N = 7;                // N can go up to 16 
  
  
  // reset (Done inside a clocked always block)
  // All the initializations must happen within the reset block
  // Recommended to use non-blocking assignments inside a clocked always block
  always@(posedge clk)
     begin
       if(rst == 0) // Active Low Reset
          begin
             count <= 0;   // Reset the value of the register variable count
          end
       else  count <= count_next;  // Update the count value
     end

// Separate always block to take care of "flag" handling
// Updating the flag content to make sure that it is always updated
always@(posedge clk)
  begin
    if(rst == 0)         flag <= 0;
    else 
      begin
        if(count == 0)   flag <= 0;
        if(count == N-1) flag <= 1;
      end
  end
  
  
  // Count generation block (Done within a combinational always block)
  // Recommended to use blocking assignments inside a combinational always block
  always@(*)
    begin
      if(ctrl == 0)       count_next = count;                                        // ctrl = 0 => hold previous value
      else if(ctrl == 1)  count_next = (count == N-1) ? 0     : (count + 1);         // ctrl = 1 => Up Count
      else if(ctrl == 2)  count_next = (count == 0)   ? (N-1) : (count - 1);         // ctrl = 2 => Down Count   
      else if(ctrl == 3)  count_next = (flag == 0) ? (count + 1) : (count-1);
      else if(ctrl == 4)  count_next = data;                                        // ctrl = 4 => load data
      else                count_next = count;                                       // Just hold the data  for ctrl = 5,6,7 (To avoid unintentional latch creation)
    end
endmodule
