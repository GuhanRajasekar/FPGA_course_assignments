module shift_register(data,rst,clk,result);
  input data,rst,clk;
  output reg [3:0] result;   // register to hold the output values
  reg qa, qb, qc, qd;
  
  
  always@(*)
     begin
        result[3:0] = {qa,qb,qc,qd};
     end
     
    
  always@(posedge clk)
    begin
      if(rst == 0) 
         begin
            qa <= 1'b0;     // Good practice to use Non Blocking assignments inside clocked always blocks
            qb <= 1'b0;
            qc <= 1'b0;
            qd <= 1'b0;
         end
       
       else
          begin
            qa <= data;
            qb <= qa;
            qc <= qb;
            qd <= qc;
          end
    end
endmodule
