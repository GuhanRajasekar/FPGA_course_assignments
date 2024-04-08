`timescale 1ns / 1ps

module cordic_tan_tb;
  reg  signed  [19:0] target_angle;
  reg clk,rst;
  wire signed [19:0] x_res;
  wire signed [19:0] y_res;
  wire signed [19:0] tan_res;
  cordic_tan c(.clk(clk),.rst(rst),.target_angle(target_angle),.x_res(x_res),.y_res(y_res),.tan_res(tan_res));
  
  integer fh_tan; // Variable for file handle
  
  // Always block to keep toggling the clock signal
  always #2 clk = ~clk;
  
  initial
     begin
     fh_tan = $fopen("F:/PhD_IISc/Coursework/Jan_2024/FPGA/FPGA_course_assignments/Mini_Project/Source_Code/Data/tan_data.txt","w");
     $fmonitor(fh_tan,"%b %d",tan_res,target_angle);

//      $monitor("%b",x_res); 
       // here we define the target angle
       // 16 bits for the integer part and 4 bits for the fractional part of the target angle
       #0 clk = 1'b0; rst = 1'b0; target_angle = 20'b11111111110000010000; //-63 degrees
       #10 rst = 1'b1; 
       // In target_angle, we have 58.54 (16 bits for integer part and 4 bits for the fractional part)
        #10 target_angle = 20'b11111111110000010000; //-63 degrees
#10 target_angle = 20'b11111111110000100000; //-62 degrees
#10 target_angle = 20'b11111111110000110000; //-61 degrees
#10 target_angle = 20'b11111111110001000000; //-60 degrees
#10 target_angle = 20'b11111111110001010000; //-59 degrees
#10 target_angle = 20'b11111111110001100000; //-58 degrees
#10 target_angle = 20'b11111111110001110000; //-57 degrees
#10 target_angle = 20'b11111111110010000000; //-56 degrees
#10 target_angle = 20'b11111111110010010000; //-55 degrees
#10 target_angle = 20'b11111111110010100000; //-54 degrees
#10 target_angle = 20'b11111111110010110000; //-53 degrees
#10 target_angle = 20'b11111111110011000000; //-52 degrees
#10 target_angle = 20'b11111111110011010000; //-51 degrees
#10 target_angle = 20'b11111111110011100000; //-50 degrees
#10 target_angle = 20'b11111111110011110000; //-49 degrees
#10 target_angle = 20'b11111111110100000000; //-48 degrees
#10 target_angle = 20'b11111111110100010000; //-47 degrees
#10 target_angle = 20'b11111111110100100000; //-46 degrees
#10 target_angle = 20'b11111111110100110000; //-45 degrees
#10 target_angle = 20'b11111111110101000000; //-44 degrees
#10 target_angle = 20'b11111111110101010000; //-43 degrees
#10 target_angle = 20'b11111111110101100000; //-42 degrees
#10 target_angle = 20'b11111111110101110000; //-41 degrees
#10 target_angle = 20'b11111111110110000000; //-40 degrees
#10 target_angle = 20'b11111111110110010000; //-39 degrees
#10 target_angle = 20'b11111111110110100000; //-38 degrees
#10 target_angle = 20'b11111111110110110000; //-37 degrees
#10 target_angle = 20'b11111111110111000000; //-36 degrees
#10 target_angle = 20'b11111111110111010000; //-35 degrees
#10 target_angle = 20'b11111111110111100000; //-34 degrees
#10 target_angle = 20'b11111111110111110000; //-33 degrees
#10 target_angle = 20'b11111111111000000000; //-32 degrees
#10 target_angle = 20'b11111111111000010000; //-31 degrees
#10 target_angle = 20'b11111111111000100000; //-30 degrees
#10 target_angle = 20'b11111111111000110000; //-29 degrees
#10 target_angle = 20'b11111111111001000000; //-28 degrees
#10 target_angle = 20'b11111111111001010000; //-27 degrees
#10 target_angle = 20'b11111111111001100000; //-26 degrees
#10 target_angle = 20'b11111111111001110000; //-25 degrees
#10 target_angle = 20'b11111111111010000000; //-24 degrees
#10 target_angle = 20'b11111111111010010000; //-23 degrees
#10 target_angle = 20'b11111111111010100000; //-22 degrees
#10 target_angle = 20'b11111111111010110000; //-21 degrees
#10 target_angle = 20'b11111111111011000000; //-20 degrees
#10 target_angle = 20'b11111111111011010000; //-19 degrees
#10 target_angle = 20'b11111111111011100000; //-18 degrees
#10 target_angle = 20'b11111111111011110000; //-17 degrees
#10 target_angle = 20'b11111111111100000000; //-16 degrees
#10 target_angle = 20'b11111111111100010000; //-15 degrees
#10 target_angle = 20'b11111111111100100000; //-14 degrees
#10 target_angle = 20'b11111111111100110000; //-13 degrees
#10 target_angle = 20'b11111111111101000000; //-12 degrees
#10 target_angle = 20'b11111111111101010000; //-11 degrees
#10 target_angle = 20'b11111111111101100000; //-10 degrees
#10 target_angle = 20'b11111111111101110000; //-9 degrees
#10 target_angle = 20'b11111111111110000000; //-8 degrees
#10 target_angle = 20'b11111111111110010000; //-7 degrees
#10 target_angle = 20'b11111111111110100000; //-6 degrees
#10 target_angle = 20'b11111111111110110000; //-5 degrees
#10 target_angle = 20'b11111111111111000000; //-4 degrees
#10 target_angle = 20'b11111111111111010000; //-3 degrees
#10 target_angle = 20'b11111111111111100000; //-2 degrees
#10 target_angle = 20'b11111111111111110000; //-1 degrees
#10 target_angle = 20'b00000000000000000000; //0 degrees
#10 target_angle = 20'b00000000000000010000; //1 degrees
#10 target_angle = 20'b00000000000000100000; //2 degrees
#10 target_angle = 20'b00000000000000110000; //3 degrees
#10 target_angle = 20'b00000000000001000000; //4 degrees
#10 target_angle = 20'b00000000000001010000; //5 degrees
#10 target_angle = 20'b00000000000001100000; //6 degrees
#10 target_angle = 20'b00000000000001110000; //7 degrees
#10 target_angle = 20'b00000000000010000000; //8 degrees
#10 target_angle = 20'b00000000000010010000; //9 degrees
#10 target_angle = 20'b00000000000010100000; //10 degrees
#10 target_angle = 20'b00000000000010110000; //11 degrees
#10 target_angle = 20'b00000000000011000000; //12 degrees
#10 target_angle = 20'b00000000000011010000; //13 degrees
#10 target_angle = 20'b00000000000011100000; //14 degrees
#10 target_angle = 20'b00000000000011110000; //15 degrees
#10 target_angle = 20'b00000000000100000000; //16 degrees
#10 target_angle = 20'b00000000000100010000; //17 degrees
#10 target_angle = 20'b00000000000100100000; //18 degrees
#10 target_angle = 20'b00000000000100110000; //19 degrees
#10 target_angle = 20'b00000000000101000000; //20 degrees
#10 target_angle = 20'b00000000000101010000; //21 degrees
#10 target_angle = 20'b00000000000101100000; //22 degrees
#10 target_angle = 20'b00000000000101110000; //23 degrees
#10 target_angle = 20'b00000000000110000000; //24 degrees
#10 target_angle = 20'b00000000000110010000; //25 degrees
#10 target_angle = 20'b00000000000110100000; //26 degrees
#10 target_angle = 20'b00000000000110110000; //27 degrees
#10 target_angle = 20'b00000000000111000000; //28 degrees
#10 target_angle = 20'b00000000000111010000; //29 degrees
#10 target_angle = 20'b00000000000111100000; //30 degrees
#10 target_angle = 20'b00000000000111110000; //31 degrees
#10 target_angle = 20'b00000000001000000000; //32 degrees
#10 target_angle = 20'b00000000001000010000; //33 degrees
#10 target_angle = 20'b00000000001000100000; //34 degrees
#10 target_angle = 20'b00000000001000110000; //35 degrees
#10 target_angle = 20'b00000000001001000000; //36 degrees
#10 target_angle = 20'b00000000001001010000; //37 degrees
#10 target_angle = 20'b00000000001001100000; //38 degrees
#10 target_angle = 20'b00000000001001110000; //39 degrees
#10 target_angle = 20'b00000000001010000000; //40 degrees
#10 target_angle = 20'b00000000001010010000; //41 degrees
#10 target_angle = 20'b00000000001010100000; //42 degrees
#10 target_angle = 20'b00000000001010110000; //43 degrees
#10 target_angle = 20'b00000000001011000000; //44 degrees
#10 target_angle = 20'b00000000001011010000; //45 degrees
#10 target_angle = 20'b00000000001011100000; //46 degrees
#10 target_angle = 20'b00000000001011110000; //47 degrees
#10 target_angle = 20'b00000000001100000000; //48 degrees
#10 target_angle = 20'b00000000001100010000; //49 degrees
#10 target_angle = 20'b00000000001100100000; //50 degrees
#10 target_angle = 20'b00000000001100110000; //51 degrees
#10 target_angle = 20'b00000000001101000000; //52 degrees
#10 target_angle = 20'b00000000001101010000; //53 degrees
#10 target_angle = 20'b00000000001101100000; //54 degrees
#10 target_angle = 20'b00000000001101110000; //55 degrees
#10 target_angle = 20'b00000000001110000000; //56 degrees
#10 target_angle = 20'b00000000001110010000; //57 degrees
#10 target_angle = 20'b00000000001110100000; //58 degrees
#10 target_angle = 20'b00000000001110110000; //59 degrees
#10 target_angle = 20'b00000000001111000000; //60 degrees
#10 target_angle = 20'b00000000001111010000; //61 degrees
#10 target_angle = 20'b00000000001111100000; //62 degrees
#10 target_angle = 20'b00000000001111110000; //63 degrees


        $fclose(fh_tan);
        #20 $finish;
     end
endmodule
