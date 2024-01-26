module modcounter(clk,ctrl,data,count);
   
  input clk;
  input [2:0] ctrl;  // to decide what the counter must do
  input [3:0] data;
  output reg [3:0] count;
  reg flag;   // register variable to keep track of whether up count or down count needs to be performed
  parameter N = 7;  // N can go up to 16 
  
  initial  flag  = 0; // flag initialized to 1 to indicate up count  (only for simulation)
  
  always@(posedge clk)
    begin
           if(ctrl == 3'b000) count <= 4'b0000;                  // ctrl = 0 => Local Synchronous reset
      else if(ctrl == 3'b001) count <= count;                    // ctrl = 1 => hold previous value
      else if(ctrl == 3'b010) count <= (count+1)%N;              // ctrl = 2 => up count
      else if(ctrl == 3'b011) count <= count-1;                  // ctrl = 3 => down count
           
      else if(ctrl == 3'b100)                                    // ctrl = 4 => count up / down [first up and then down]
               begin
                 if(flag == 1'b0)                                // indicates up count (The x is for simulation purposes)
                    begin
                       if(count == N-1 )
                         begin  
                            flag  <= 1;                          // Max count is reached => Change the status of the flag to indicate 
                            count <= count - 1;                  // Decrement the count once for this clock cycle
                          end
                       else  count <= count + 1;                 // Max count is not yet reached => Continue up counting
                    end
                 
                 else                                            // flag = 1 indicates down count
                    begin
                       if(count == 0) 
                         begin
                           flag <= 0;                            // Min count is reached => Reset the flag
                           count = count + 1;                    // Increment the count once for this clock cycle
                         end
                       else count <= count - 1;                  // Min count is not yet reached => Continue down counting
                    end 
               end
           
      else if(ctrl == 3'b101) count <= data;                     // ctrl = 5 => load data
      else                    count <= count;                    // Just hold the data  for ctrl = 6,7
    end
endmodule
