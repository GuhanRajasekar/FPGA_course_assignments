// this is the code for mealy detection of sequence 1010

`timescale 1ns/1ps
module seq_detector(x,clk,rst,y,curr_state);
  input  x,clk,rst;                   // input data , reset and clock signals
  output reg y;                      // reg variable to store the output  
  output reg [1:0] curr_state;      // reg variable to store the current state of the circuit
  
  reg [1:0] next_state;  // reg variable to do the next state computation in a "combinational always block"
  
  // Clocked always block to do all the updates in the output and the current state registers
  // Good practise to use non blocking assignments in a clocked always block
  always@(posedge clk)
    begin
       if(rst == 0)
          begin
             curr_state  <= 2'b00;  // On reset we start from state 00
          end
       else
          begin
            curr_state <= next_state;
          end
    end
    
// Combinational always block to do all the computations
// Good practise to use blocking assignments in a combinational always block
always@(*)
   begin
      if(rst == 0)
        begin
          next_state = 2'b00;   // Here we add this statement to avoid inferred latches
          y          = 0;
        end // if(rst == 0)
      
      else
        begin
              case(curr_state)
              2'b00: 
                  begin
                     next_state = (x == 0) ? (2'b00) : (2'b01);
                     y          = 1'b0; 
                  end
              
              2'b01:
                  begin
                     next_state = (x == 0) ? (2'b11) : (2'b01);
                     y          = 1'b0;
                  end
              
              2'b11:
                  begin
                     next_state = (x == 0) ? (2'b00) : (2'b10);
                     y          = 0;
                  end
              2'b10:
                  begin
                     next_state = (x == 0) ? (2'b11) : (2'b01);
                     y          = (x == 0) ? 1 : 0;
                  end
              default:
                  begin
                     next_state = 2'b00;
                     y = 0;
                  end
              endcase
        end  // else
   end // end statement for the clocked always block
endmodule