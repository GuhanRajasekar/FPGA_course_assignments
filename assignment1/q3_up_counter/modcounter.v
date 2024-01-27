module modcounter(clk,rst,ctrl,data,count);
   
  input clk,rst;
  input [2:0] ctrl;  // to decide what the counter must do
  input [3:0] data;
  output reg [3:0] count;
  reg flag;   // register variable to keep track of whether up count or down count needs to be performed
  parameter N = 7;  // N can go up to 16 
  
  always@(posedge clk)
    begin
           if(rst  == 1'b1)   
             begin
                count <= 4'b0000;                                // rst  = 1 => Local Synchronous reset
                flag  <= 0;                                      // flag = 0 => Indicates Up Counting
             end
      else if(ctrl == 3'b000) count <= count;                    // ctrl = 0 => hold previous value
      else if(ctrl == 3'b001) count <= (count+1)%N;              // ctrl = 1 => up count
      else if(ctrl == 3'b010)                                    // ctrl = 2 => down count
          begin
             if(count == 4'b0000)   count <= N-1;
             else                   count <= count-1;
          end
           
      else if(ctrl == 3'b011)                                    // ctrl = 3 => count up / down [first up and then down]
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
           
      else if(ctrl == 3'b100) count <= data;                     // ctrl = 4 => load data
      else                    count <= count;                    // Just hold the data  for ctrl = 5,6,7
    end
endmodule
