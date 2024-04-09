`timescale 1ns / 1ps

module sincos_pipelined(
input Clock,Reset,
input signed [11:0] Angle,
output signed [11:0] Sin, Cos
);

reg signed [11:0] xa,ya,za;

// Here Clock is the natural 10MHz clock
// xa, ya, za are the initialization values that are necessary for the cordic_pipelined block
// cordic_pipelined module contains the 12 iterations that are necessary for computing sin and cos of the given angle
// The result given by cordic_pipelined is stored in X_result and Y_result
cordic_pipelined cordicinst(.Clock(Clock),.Reset(Reset),.X(xa),.Y(ya),.Z(za),.X_result(Cos),.Y_result(Sin));    
    

// Here the Clock is the natural 10MHZ clock present in the FPGA board    
always @(posedge Clock) begin

if (Reset) begin
xa <= 12'h000;
ya <= 12'h000;
za <= 12'h000;
end
else  begin

if (Angle[11:10] == 2'b01 || Angle[11:10] == 2'b10) begin
xa <= -12'h4db;
ya <= 12'h000;
za <= {~Angle[11], Angle[10:0]};
end 
else begin
xa <= 12'h4db; // 0.100 1101 1011 = 0.6069 (1 bit for the integer part and 11 bits for the fractional part)
ya <= 12'h000; // 0000  0000 0000 = 0.0000 (1 bit for the integer part and 11 bits for the fractional part)
za <= Angle;
end

end


end
       
endmodule
