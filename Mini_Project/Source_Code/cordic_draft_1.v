module cordic(target_angle,x_res,y_res);

// Apparently verilog does not support two dimensional arrays as ports (system verilog does)
// However, let us see if this works for simulation

 input signed [19:0] target_angle;   // 20 bits to denote the target angle of rotation (16 bits including MSB for the integer part and 4 bits for the fractional part)
 output reg signed [19:0] x_res; // 6 bits (2 for integer part and 16 for fractional part) to store the x-coordinate of the final rotated vector
 output reg signed [19:0] y_res; // 6 bits (2 for integer part and 16 for fractional part) to store the y-coordinate of the final rotated vector
 
 reg signed [19:0] x [9:0];  // to store the x-coordinates of each step (2 bits for the integer part including MSB and 16 bits for the fractional part)
 reg signed [19:0] y [9:0];  // to store the y-coordinates of each step (2 bits for the integer part including MSB and 16 bits for the fractional part)
 
 wire signed[19:0] arc_tan [9:0];       // to store look up values of arc tan using 20 bits (16 bits including MSB to denote the integer part and 4 bits to denote the fractional part)
 reg  signed[19:0] rotation_angle[9:0];  // Array of 20 bit registers to store the rotated angle 
 reg  rotation_direction[9:0]; // Array of 1 bit registers to denote the direction of rotation. 1/0 => Anticlockwise / Clockwise rotation 
 
 assign arc_tan[0] = {{6{1'b0}},{10{1'b0}},{4{1'b0}}};     // 0       degrees
 assign arc_tan[1] = {{6{1'b0}},10'b0000101101,4'b0000};   // 45      degrees
 assign arc_tan[2] = {{6{1'b0}},10'b0000011010,4'b1001};   // 26.565  degrees
 assign arc_tan[3] = {{6{1'b0}},10'b0000001110,4'b0000};   // 14.0362 degrees
 assign arc_tan[4] = {{6{1'b0}},10'b0000000111,4'b0010};   // 7.125   degrees
 assign arc_tan[5] = {{6{1'b0}},10'b0000000011,4'b1001};   // 3.5763  degrees
 assign arc_tan[6] = {{6{1'b0}},10'b0000000001,4'b1100};   // 1.7899  degrees
 assign arc_tan[7] = {{6{1'b0}},10'b0000000000,4'b1110};   // 0.8951  degrees
 assign arc_tan[8] = {{6{1'b0}},10'b0000000000,4'b0111};   // 0.4476  degrees
 assign arc_tan[9] = {{6{1'b0}},10'b0000000000,4'b0011};   // 0.2238  degrees
 assign arc_tan[10] ={{6{1'b0}},10'b0000000000,4'b0001};   // 0.1119  degrees
 
 always@(*)
   begin
// iteration 0:
      // taking k (scaling factor) as 0.6072
      x[0] = 20'b00001001101101110001; // x[0] = 0.6072 (2 bits for the integer part and 10 bits for the fractional part)
      y[0] = 20'b00000000000000000000; // y[0] = 0.0000 (2 bits for the integer part and 10 bits for the fractional part)
      rotation_angle[0] = arc_tan[0]; // First we always rotate by 0 degrees => Update the rotated angle accordingly
      /* For the first time, rotation direction is always 1 assuming the target angle is between 0 and 90 */
      rotation_direction[0] = (rotation_angle[0] < target_angle) ? 1 : 0 ;
       
//iteration 1
      x[1] = (rotation_direction[0] == 1) ?(x[0] - y[0]) : (x[0] + y[0]);
      y[1] = (rotation_direction[0] == 1) ?(y[0] + x[0]) : (y[0] - x[0]);
      // Curr accumulative rotated angle = Previously rotated angle + Curr value from the look up table
      rotation_angle[1] = (rotation_direction[0] == 1) ? (rotation_angle[0] + arc_tan[1]) : (rotation_angle[0] - arc_tan[1]);
      // Check in which direction we need to rotate for the next iteration. 
      // If the angle we have rotated so far is less than the target angle, then rotate in anticlockwise direction (rotation_direction[i] = 1)
      // If the angle we have rotated so far is more than the target angle, then rotate in clockwise direction (rotation_direction[i] = 0)
      rotation_direction[1] = (rotation_angle[1] < target_angle) ? 1 : 0 ;
         
//iteration 2
      x[2] = (rotation_direction[1] == 1) ? (x[1] - (y[1]>>>1)) : (x[1] + (y[1]>>>1));
      y[2] = (rotation_direction[1] == 1) ? (y[1] + (x[1]>>>1)) : (y[1] - (x[1]>>>1));
      rotation_angle[2]     = (rotation_direction[1] == 1) ? (rotation_angle[1] + arc_tan[2]) : (rotation_angle[1] - arc_tan[2]);
      rotation_direction[2] = (rotation_angle[2] < target_angle) ? 1:0;
      
//iteration 3
      x[3] = (rotation_direction[2] == 1) ? (x[2] - (y[2]>>>2)) : (x[2] + (y[2]>>>2));
      y[3] = (rotation_direction[2] == 1) ? (y[2] + (x[2]>>>2)) : (y[2] - (x[2]>>>2));
      rotation_angle[3]     = (rotation_direction[2] == 1) ? (rotation_angle[2] + arc_tan[3]) : (rotation_angle[2] - arc_tan[3]);
      rotation_direction[3] = (rotation_angle[3] < target_angle) ? 1:0;

//iteration 4
      x[4] = (rotation_direction[3] == 1) ? (x[3] - (y[3]>>>3)) : (x[3] + (y[3]>>>3));
      y[4] = (rotation_direction[3] == 1) ? (y[3] + (x[3]>>>3)) : (y[3] - (x[3]>>>3));
      rotation_angle[4]      = (rotation_direction[3] == 1) ? (rotation_angle[3] + arc_tan[4]) : (rotation_angle[3] - arc_tan[4]);
      rotation_direction[4]  = (rotation_angle[4] < target_angle) ? 1:0;
       
//iteration 5
      x[5] = (rotation_direction[4] == 1) ? (x[4] - (y[4]>>>4)) : (x[4] + (y[4]>>>4));
      y[5] = (rotation_direction[4] == 1) ? (y[4] + (x[4]>>>4)) : (y[4] - (x[4]>>>4));
      rotation_angle[5]      = (rotation_direction[4] == 1) ? (rotation_angle[4] + arc_tan[5]) : (rotation_angle[4] - arc_tan[5]);
      rotation_direction[5]  = (rotation_angle[5] < target_angle) ? 1:0;

//iteration 6
      x[6] = (rotation_direction[5] == 1) ? (x[5] - (y[5]>>>5)) : (x[5] + (y[5]>>>5));
      y[6] = (rotation_direction[5] == 1) ? (y[5] + (x[5]>>>5)) : (y[5] - (x[5]>>>5));
      rotation_angle[6]      = (rotation_direction[5] == 1) ? (rotation_angle[5] + arc_tan[6]) : (rotation_angle[5] - arc_tan[6]);
      rotation_direction[6]  = (rotation_angle[6] < target_angle) ? 1:0;

//iteration 7
      x[7] = (rotation_direction[6] == 1) ? (x[6] - (y[6]>>>6)) : (x[6] + (y[6]>>>6));
      y[7] = (rotation_direction[6] == 1) ? (y[6] + (x[6]>>>6)) : (y[6] - (x[6]>>>6));
      rotation_angle[7]      = (rotation_direction[6] == 1) ? (rotation_angle[6] + arc_tan[7]) : (rotation_angle[6] - arc_tan[7]);
      rotation_direction[7]  = (rotation_angle[7] < target_angle) ? 1:0;
      
//iteration 8
      x[8] = (rotation_direction[7] == 1) ? (x[7] - (y[7]>>>7)) : (x[7] + (y[7]>>>7));
      y[8] = (rotation_direction[7] == 1) ? (y[7] + (x[7]>>>7)) : (y[7] - (x[7]>>>7));
      rotation_angle[8]      = (rotation_direction[7] == 1) ? (rotation_angle[7] + arc_tan[8]) : (rotation_angle[7] - arc_tan[8]);
      rotation_direction[8]  = (rotation_angle[7] < target_angle) ? 1:0;
      
//iteration 9
      x[9] = (rotation_direction[8] == 1) ? (x[8] - (y[8]>>>8)) : (x[8] + (y[8]>>>8));
      y[9] = (rotation_direction[8] == 1) ? (y[8] + (x[8]>>>8)) : (y[8] - (x[8]>>>8));
      rotation_angle[9]      = (rotation_direction[8] == 1) ? (rotation_angle[8] + arc_tan[9]) : (rotation_angle[8] - arc_tan[9]);
      rotation_direction[9]  = (rotation_angle[8] < target_angle) ? 1:0;    
   end
   
always@(*)
   begin
      x_res [19:0] = x[9][19:0];
      y_res [19:0] = y[9][19:0];
   end
endmodule

// We still need to take care of the edge cases of 0 degrees and 90 degrees