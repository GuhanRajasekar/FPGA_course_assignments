`timescale 10ns/1ns

module cla(so,co,a,b,cin); // mostly every line except "endmoule" will end with semi-colon
   input[3:0] a,b;
   input cin;
   output reg[3:0] so;
   output reg co;
   
   wire [3:0] co_temp; // wires that will be continuosly driven with the values of output carry of each stage
   wire [3:0] so_temp;  // wires that will be continuosly driven with the values of output sum of each stage
   
   assign co_temp[0] = (a[0]*b[0]) + ((a[0]^b[0])*cin);
   assign so_temp[0]  = (a[0] ^ b[0] ^ cin);
   
   assign co_temp[1]  = (a[1]*b[1]) + ((a[1]^b[1])*co_temp[0]);
   assign so_temp[1]  = (a[1] ^ b[1] ^ co_temp[0]);
   
   assign co_temp[2]  = (a[2]*b[2]) + ((a[2]^b[2])*co_temp[1]);
   assign so_temp[2]  = (a[2] ^ b[2] ^ co_temp[1]);
   
   assign co_temp[3]   = (a[3]*b[3]) + ((a[3]^b[3])*co_temp[2]);
   assign so_temp[3]   = (a[3] ^ b[3] ^ co_temp[2]);
   
   always@(*)
      begin
	 so[3:0] <= so_temp[3:0] ;
	 co      <= co_temp[3];   
      end
endmodule
