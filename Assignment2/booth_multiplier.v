`timescale 1ns/1ps
module genPP(a,x,pp);
input  [2:0]   a;     // register to store 3 bits of the mutiplicand based on which Partial product is generated
input  [7:0]   x;     // register to store the multiplcand
output reg [9:0] pp;  //  8 bit register to store the partial product
reg [9:0] temp;       // register to hold temporary values
reg [7:0] temp1;

always@(*)
  begin
     case(a)
       3'b000: pp[9:0] = {10{1'b0}};      // 0
       3'b001: pp[9:0] = {{2{x[7]}},x};   // x with 2 bits sign extension
       3'b010: pp[9:0] = {{2{x[7]}},x};   // x with 2 bits sign extension
       3'b011: pp[9:0] = {x[7],x,1'b0};   // 2x
       3'b100:
          begin
               temp = {x[7],x,1'b0};   // 2x
               pp   = -temp;           // -2x ('-' in veriilog will take 2's complement)
          end
       3'b101:
          begin
               temp1   = -x;
               pp[9:0] = {{2{temp1[7]}} , temp1};
          end
       3'b110:
          begin
               temp1   = -x;
               pp[9:0] = {{2{temp1[7]}} , temp1};    // -x
          end               
       3'b111: pp = {10{1'b0}};                 // 0
      default: pp = {10{1'b0}};
     endcase
  end
  
endmodule


module booth_multiplier(x,y,clk,rst,result,carry);
  input [7:0]  x;   // register to store the multiplicand
  input [7:0]  y;   // register to store the multiplier
  input clk,rst;     //
  output reg  [15:0] result;   // register to store the final result
  output reg  carry;
  
  // 10 bit wires to denote the temporary partial products
  // These partial products do not have sign extension or zero padding at LSB
  // Having it as 10 bits will help us avoid losing the MSB with Left Shifting
  // When MSB of 1 is left shifted and if it is lost, we may end up with wrong results
  wire [9:0] pp0_temp , pp1_temp , pp2_temp , pp3_temp;
  
  reg [7:0] x_reg,y_reg;       // 8 bit registers to hold the mulitplicand and the multiplier values
  reg [15:0] pp0, pp1,pp2,pp3; // 16 bit register to store the complete partial products with sign extension at MSB and zero padding at the LSB
  
  //module instantiations to generate the partial products without sign extension at the MSB and zero padding at the LSB
  genPP G (.a({y_reg[1:0],1'b0}) , .x(x_reg) , .pp(pp0_temp));
  genPP U (.a( y_reg[3:1]   )    , .x(x_reg) , .pp(pp1_temp));
  genPP H (.a( y_reg[5:3]   )    , .x(x_reg) , .pp(pp2_temp));
  genPP A (.a( y_reg[7:5]   )    , .x(x_reg) , .pp(pp3_temp));
  
  always@(posedge clk)
    begin
       if(rst == 0)               // Reset all the input and output registers
         begin
           x_reg   <= 8'b0;
           y_reg   <= 8'b0;
           result  <= 16'b0;
           carry   <= 1'b0;
         end
       else                      // Load all the input and the output registers with appropriate values
         begin
            x_reg <= x;
            y_reg <= y;
            {carry , result} <= (pp0 + pp1 + pp2 + pp3);          
         end
    end
    
  always@(*)
     begin
         pp0 = { {6{pp0_temp[9]}} , pp0_temp};                  // 6 bits at MSB for sign extension and zero bits at LSB for zero padding
         pp1 = { {4{pp1_temp[9]}} , pp1_temp , {2{1'b0}}};      // 4 bits at MSB for sign extension and two  bits at LSB for zero padding
         pp2 = { {2{pp2_temp[9]}} , pp2_temp , {4{1'b0}}};      // 2 bits at MSB for sign extension and four bits at LSB for zero padding
         pp3 = { pp3_temp , {6{1'b0}}};                         // six  bits at LSB for zero padding
     end
endmodule 
