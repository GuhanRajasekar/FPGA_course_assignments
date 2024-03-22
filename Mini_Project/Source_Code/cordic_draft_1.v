module cordic(target_angle);
 // taking k (scaling factor) as 0.6072
 input target_angle;
 reg signed [5:0] x   [9:0];  // to store the x-coordinates of each step (2 bits for the integer part including MSB and 4 bits for the fractional part)
 reg signed [5:0] y   [9:0];  // to store the y-coordinates of each step (2 bits for the integer part including MSB and 4 bits for the fractional part)
 
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
 assign arc_tan[10] = {{6{1'b0}},10'b0000000000,4'b0001};   // 0.1119  degrees
 
 always@(*)
   begin
// iteration 0:
      x[0] = 6'b001001 ; // x[0] = 0.6072 (2 bits for the integer part and 4 bits for the fractional part)
      y[0] = 6'b000000 ; // y[0] = 0.0000 (2 bits for the integer part and 4 bits for the fractional part)
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
      x[2] = (rotation_direction[0] == 1) ? (x[1] - (y[1]>>>1)) : (x[1] + (y[1]>>>1));
      y[2] = (rotation_direction[0] == 1) ? (y[1] + (x[1]>>>1)) : (y[1] - (x[1]>>>1));
      rotation_angle[2]     = (rotation_direction[1] == 1) ? (rotation_angle[1] + arc_tan[2]) : (rotation_angle[1] - arc_tan[2]);
      rotation_direction[2] = (rotation_angle[2] < target_angle) ? 1:0;
      
//iteration 3
//iteration 4
//iteration 5
//iteration 6
//iteration 7
//iteration 8
//iteration 9
//iteration 10
      
   end
endmodule