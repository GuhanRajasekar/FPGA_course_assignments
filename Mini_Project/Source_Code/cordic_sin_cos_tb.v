`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2024 13:16:37
// Design Name: 
// Module Name: cordic_sin_cos_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cordic_sin_cos_tb;
  reg  signed  [19:0] target_angle;
  reg clk,rst;
  wire signed [19:0] x_res;
  wire signed [19:0] y_res;
  cordic_sin_cos c(.clk(clk),.rst(rst),.target_angle(target_angle), .x_res(x_res) , .y_res(y_res));
  
  integer fh_cos; // Variable for file handle
  integer fh_sin; // Variable for file handle
  
  // Always block to keep toggling the clock signal
  always #2 clk = ~clk;
  
  initial
     begin
     fh_cos = $fopen("F:/PhD_IISc/Coursework/Jan_2024/FPGA/FPGA_course_assignments/Mini_Project/Source_Code/Data/cos_data.txt","w");
     $fmonitor(fh_cos,"%b %d",x_res,target_angle);
     fh_sin = $fopen("F:/PhD_IISc/Coursework/Jan_2024/FPGA/FPGA_course_assignments/Mini_Project/Source_Code/Data/sin_data.txt","w");
     $fmonitor(fh_sin,"%b %d",y_res,target_angle);
//      $monitor("%b",x_res); 
       // here we define the target angle
       // 16 bits for the integer part and 4 bits for the fractional part of the target angle
       #0 clk = 1'b0; rst = 1'b0;
       #1 rst = 1'b1; 
       // In target_angle, we have 58.54 (16 bits for integer part and 4 bits for the fractional part)
       #15 target_angle = 20'b00000000000000000000; //0 degrees
        #15 target_angle = 20'b00000000000000010000; //1 degrees
        #15 target_angle = 20'b00000000000000100000; //2 degrees
        #15 target_angle = 20'b00000000000000110000; //3 degrees
        #15 target_angle = 20'b00000000000001000000; //4 degrees
        #15 target_angle = 20'b00000000000001010000; //5 degrees
        #15 target_angle = 20'b00000000000001100000; //6 degrees
        #15 target_angle = 20'b00000000000001110000; //7 degrees
        #15 target_angle = 20'b00000000000010000000; //8 degrees
        #15 target_angle = 20'b00000000000010010000; //9 degrees
        #15 target_angle = 20'b00000000000010100000; //10 degrees
        #15 target_angle = 20'b00000000000010110000; //11 degrees
        #15 target_angle = 20'b00000000000011000000; //12 degrees
        #15 target_angle = 20'b00000000000011010000; //13 degrees
        #15 target_angle = 20'b00000000000011100000; //14 degrees
        #15 target_angle = 20'b00000000000011110000; //15 degrees
        #15 target_angle = 20'b00000000000100000000; //16 degrees
        #15 target_angle = 20'b00000000000100010000; //17 degrees
        #15 target_angle = 20'b00000000000100100000; //18 degrees
        #15 target_angle = 20'b00000000000100110000; //19 degrees
        #15 target_angle = 20'b00000000000101000000; //20 degrees
        #15 target_angle = 20'b00000000000101010000; //21 degrees
        #15 target_angle = 20'b00000000000101100000; //22 degrees
        #15 target_angle = 20'b00000000000101110000; //23 degrees
        #15 target_angle = 20'b00000000000110000000; //24 degrees
        #15 target_angle = 20'b00000000000110010000; //25 degrees
        #15 target_angle = 20'b00000000000110100000; //26 degrees
        #15 target_angle = 20'b00000000000110110000; //27 degrees
        #15 target_angle = 20'b00000000000111000000; //28 degrees
        #15 target_angle = 20'b00000000000111010000; //29 degrees
        #15 target_angle = 20'b00000000000111100000; //30 degrees
        #15 target_angle = 20'b00000000000111110000; //31 degrees
        #15 target_angle = 20'b00000000001000000000; //32 degrees
        #15 target_angle = 20'b00000000001000010000; //33 degrees
        #15 target_angle = 20'b00000000001000100000; //34 degrees
        #15 target_angle = 20'b00000000001000110000; //35 degrees
        #15 target_angle = 20'b00000000001001000000; //36 degrees
        #15 target_angle = 20'b00000000001001010000; //37 degrees
        #15 target_angle = 20'b00000000001001100000; //38 degrees
        #15 target_angle = 20'b00000000001001110000; //39 degrees
        #15 target_angle = 20'b00000000001010000000; //40 degrees
        #15 target_angle = 20'b00000000001010010000; //41 degrees
        #15 target_angle = 20'b00000000001010100000; //42 degrees
        #15 target_angle = 20'b00000000001010110000; //43 degrees
        #15 target_angle = 20'b00000000001011000000; //44 degrees
        #15 target_angle = 20'b00000000001011010000; //45 degrees
        #15 target_angle = 20'b00000000001011100000; //46 degrees
        #15 target_angle = 20'b00000000001011110000; //47 degrees
        #15 target_angle = 20'b00000000001100000000; //48 degrees
        #15 target_angle = 20'b00000000001100010000; //49 degrees
        #15 target_angle = 20'b00000000001100100000; //50 degrees
        #15 target_angle = 20'b00000000001100110000; //51 degrees
        #15 target_angle = 20'b00000000001101000000; //52 degrees
        #15 target_angle = 20'b00000000001101010000; //53 degrees
        #15 target_angle = 20'b00000000001101100000; //54 degrees
        #15 target_angle = 20'b00000000001101110000; //55 degrees
        #15 target_angle = 20'b00000000001110000000; //56 degrees
        #15 target_angle = 20'b00000000001110010000; //57 degrees
        #15 target_angle = 20'b00000000001110100000; //58 degrees
        #15 target_angle = 20'b00000000001110110000; //59 degrees
        #15 target_angle = 20'b00000000001111000000; //60 degrees
        #15 target_angle = 20'b00000000001111010000; //61 degrees
        #15 target_angle = 20'b00000000001111100000; //62 degrees
        #15 target_angle = 20'b00000000001111110000; //63 degrees
        #15 target_angle = 20'b00000000010000000000; //64 degrees
        #15 target_angle = 20'b00000000010000010000; //65 degrees
        #15 target_angle = 20'b00000000010000100000; //66 degrees
        #15 target_angle = 20'b00000000010000110000; //67 degrees
        #15 target_angle = 20'b00000000010001000000; //68 degrees
        #15 target_angle = 20'b00000000010001010000; //69 degrees
        #15 target_angle = 20'b00000000010001100000; //70 degrees
        #15 target_angle = 20'b00000000010001110000; //71 degrees
        #15 target_angle = 20'b00000000010010000000; //72 degrees
        #15 target_angle = 20'b00000000010010010000; //73 degrees
        #15 target_angle = 20'b00000000010010100000; //74 degrees
        #15 target_angle = 20'b00000000010010110000; //75 degrees
        #15 target_angle = 20'b00000000010011000000; //76 degrees
        #15 target_angle = 20'b00000000010011010000; //77 degrees
        #15 target_angle = 20'b00000000010011100000; //78 degrees
        #15 target_angle = 20'b00000000010011110000; //79 degrees
        #15 target_angle = 20'b00000000010100000000; //80 degrees
        #15 target_angle = 20'b00000000010100010000; //81 degrees
        #15 target_angle = 20'b00000000010100100000; //82 degrees
        #15 target_angle = 20'b00000000010100110000; //83 degrees
        #15 target_angle = 20'b00000000010101000000; //84 degrees
        #15 target_angle = 20'b00000000010101010000; //85 degrees
        #15 target_angle = 20'b00000000010101100000; //86 degrees
        #15 target_angle = 20'b00000000010101110000; //87 degrees
        #15 target_angle = 20'b00000000010110000000; //88 degrees
        #15 target_angle = 20'b00000000010110010000; //89 degrees
        #15 target_angle = 20'b00000000010110100000; //90 degrees
        #15 target_angle = 20'b00000000010110110000; //91 degrees
        #15 target_angle = 20'b00000000010111000000; //92 degrees
        #15 target_angle = 20'b00000000010111010000; //93 degrees
        #15 target_angle = 20'b00000000010111100000; //94 degrees
        #15 target_angle = 20'b00000000010111110000; //95 degrees
        #15 target_angle = 20'b00000000011000000000; //96 degrees
        #15 target_angle = 20'b00000000011000010000; //97 degrees
        #15 target_angle = 20'b00000000011000100000; //98 degrees
        #15 target_angle = 20'b00000000011000110000; //99 degrees
        #15 target_angle = 20'b00000000011001000000; //100 degrees
        #15 target_angle = 20'b00000000011001010000; //101 degrees
        #15 target_angle = 20'b00000000011001100000; //102 degrees
        #15 target_angle = 20'b00000000011001110000; //103 degrees
        #15 target_angle = 20'b00000000011010000000; //104 degrees
        #15 target_angle = 20'b00000000011010010000; //105 degrees
        #15 target_angle = 20'b00000000011010100000; //106 degrees
        #15 target_angle = 20'b00000000011010110000; //107 degrees
        #15 target_angle = 20'b00000000011011000000; //108 degrees
        #15 target_angle = 20'b00000000011011010000; //109 degrees
        #15 target_angle = 20'b00000000011011100000; //110 degrees
        #15 target_angle = 20'b00000000011011110000; //111 degrees
        #15 target_angle = 20'b00000000011100000000; //112 degrees
        #15 target_angle = 20'b00000000011100010000; //113 degrees
        #15 target_angle = 20'b00000000011100100000; //114 degrees
        #15 target_angle = 20'b00000000011100110000; //115 degrees
        #15 target_angle = 20'b00000000011101000000; //116 degrees
        #15 target_angle = 20'b00000000011101010000; //117 degrees
        #15 target_angle = 20'b00000000011101100000; //118 degrees
        #15 target_angle = 20'b00000000011101110000; //119 degrees
        #15 target_angle = 20'b00000000011110000000; //120 degrees
        #15 target_angle = 20'b00000000011110010000; //121 degrees
        #15 target_angle = 20'b00000000011110100000; //122 degrees
        #15 target_angle = 20'b00000000011110110000; //123 degrees
        #15 target_angle = 20'b00000000011111000000; //124 degrees
        #15 target_angle = 20'b00000000011111010000; //125 degrees
        #15 target_angle = 20'b00000000011111100000; //126 degrees
        #15 target_angle = 20'b00000000011111110000; //127 degrees
        #15 target_angle = 20'b00000000100000000000; //128 degrees
        #15 target_angle = 20'b00000000100000010000; //129 degrees
        #15 target_angle = 20'b00000000100000100000; //130 degrees
        #15 target_angle = 20'b00000000100000110000; //131 degrees
        #15 target_angle = 20'b00000000100001000000; //132 degrees
        #15 target_angle = 20'b00000000100001010000; //133 degrees
        #15 target_angle = 20'b00000000100001100000; //134 degrees
        #15 target_angle = 20'b00000000100001110000; //135 degrees
        #15 target_angle = 20'b00000000100010000000; //136 degrees
        #15 target_angle = 20'b00000000100010010000; //137 degrees
        #15 target_angle = 20'b00000000100010100000; //138 degrees
        #15 target_angle = 20'b00000000100010110000; //139 degrees
        #15 target_angle = 20'b00000000100011000000; //140 degrees
        #15 target_angle = 20'b00000000100011010000; //141 degrees
        #15 target_angle = 20'b00000000100011100000; //142 degrees
        #15 target_angle = 20'b00000000100011110000; //143 degrees
        #15 target_angle = 20'b00000000100100000000; //144 degrees
        #15 target_angle = 20'b00000000100100010000; //145 degrees
        #15 target_angle = 20'b00000000100100100000; //146 degrees
        #15 target_angle = 20'b00000000100100110000; //147 degrees
        #15 target_angle = 20'b00000000100101000000; //148 degrees
        #15 target_angle = 20'b00000000100101010000; //149 degrees
        #15 target_angle = 20'b00000000100101100000; //150 degrees
        #15 target_angle = 20'b00000000100101110000; //151 degrees
        #15 target_angle = 20'b00000000100110000000; //152 degrees
        #15 target_angle = 20'b00000000100110010000; //153 degrees
        #15 target_angle = 20'b00000000100110100000; //154 degrees
        #15 target_angle = 20'b00000000100110110000; //155 degrees
        #15 target_angle = 20'b00000000100111000000; //156 degrees
        #15 target_angle = 20'b00000000100111010000; //157 degrees
        #15 target_angle = 20'b00000000100111100000; //158 degrees
        #15 target_angle = 20'b00000000100111110000; //159 degrees
        #15 target_angle = 20'b00000000101000000000; //160 degrees
        #15 target_angle = 20'b00000000101000010000; //161 degrees
        #15 target_angle = 20'b00000000101000100000; //162 degrees
        #15 target_angle = 20'b00000000101000110000; //163 degrees
        #15 target_angle = 20'b00000000101001000000; //164 degrees
        #15 target_angle = 20'b00000000101001010000; //165 degrees
        #15 target_angle = 20'b00000000101001100000; //166 degrees
        #15 target_angle = 20'b00000000101001110000; //167 degrees
        #15 target_angle = 20'b00000000101010000000; //168 degrees
        #15 target_angle = 20'b00000000101010010000; //169 degrees
        #15 target_angle = 20'b00000000101010100000; //170 degrees
        #15 target_angle = 20'b00000000101010110000; //171 degrees
        #15 target_angle = 20'b00000000101011000000; //172 degrees
        #15 target_angle = 20'b00000000101011010000; //173 degrees
        #15 target_angle = 20'b00000000101011100000; //174 degrees
        #15 target_angle = 20'b00000000101011110000; //175 degrees
        #15 target_angle = 20'b00000000101100000000; //176 degrees
        #15 target_angle = 20'b00000000101100010000; //177 degrees
        #15 target_angle = 20'b00000000101100100000; //178 degrees
        #15 target_angle = 20'b00000000101100110000; //179 degrees
        #15 target_angle = 20'b00000000101101000000; //180 degrees
        #15 target_angle = 20'b00000000101101010000; //181 degrees
        #15 target_angle = 20'b00000000101101100000; //182 degrees
        #15 target_angle = 20'b00000000101101110000; //183 degrees
        #15 target_angle = 20'b00000000101110000000; //184 degrees
        #15 target_angle = 20'b00000000101110010000; //185 degrees
        #15 target_angle = 20'b00000000101110100000; //186 degrees
        #15 target_angle = 20'b00000000101110110000; //187 degrees
        #15 target_angle = 20'b00000000101111000000; //188 degrees
        #15 target_angle = 20'b00000000101111010000; //189 degrees
        #15 target_angle = 20'b00000000101111100000; //190 degrees
        #15 target_angle = 20'b00000000101111110000; //191 degrees
        #15 target_angle = 20'b00000000110000000000; //192 degrees
        #15 target_angle = 20'b00000000110000010000; //193 degrees
        #15 target_angle = 20'b00000000110000100000; //194 degrees
        #15 target_angle = 20'b00000000110000110000; //195 degrees
        #15 target_angle = 20'b00000000110001000000; //196 degrees
        #15 target_angle = 20'b00000000110001010000; //197 degrees
        #15 target_angle = 20'b00000000110001100000; //198 degrees
        #15 target_angle = 20'b00000000110001110000; //199 degrees
        #15 target_angle = 20'b00000000110010000000; //200 degrees
        #15 target_angle = 20'b00000000110010010000; //201 degrees
        #15 target_angle = 20'b00000000110010100000; //202 degrees
        #15 target_angle = 20'b00000000110010110000; //203 degrees
        #15 target_angle = 20'b00000000110011000000; //204 degrees
        #15 target_angle = 20'b00000000110011010000; //205 degrees
        #15 target_angle = 20'b00000000110011100000; //206 degrees
        #15 target_angle = 20'b00000000110011110000; //207 degrees
        #15 target_angle = 20'b00000000110100000000; //208 degrees
        #15 target_angle = 20'b00000000110100010000; //209 degrees
        #15 target_angle = 20'b00000000110100100000; //210 degrees
        #15 target_angle = 20'b00000000110100110000; //211 degrees
        #15 target_angle = 20'b00000000110101000000; //212 degrees
        #15 target_angle = 20'b00000000110101010000; //213 degrees
        #15 target_angle = 20'b00000000110101100000; //214 degrees
        #15 target_angle = 20'b00000000110101110000; //215 degrees
        #15 target_angle = 20'b00000000110110000000; //216 degrees
        #15 target_angle = 20'b00000000110110010000; //217 degrees
        #15 target_angle = 20'b00000000110110100000; //218 degrees
        #15 target_angle = 20'b00000000110110110000; //219 degrees
        #15 target_angle = 20'b00000000110111000000; //220 degrees
        #15 target_angle = 20'b00000000110111010000; //221 degrees
        #15 target_angle = 20'b00000000110111100000; //222 degrees
        #15 target_angle = 20'b00000000110111110000; //223 degrees
        #15 target_angle = 20'b00000000111000000000; //224 degrees
        #15 target_angle = 20'b00000000111000010000; //225 degrees
        #15 target_angle = 20'b00000000111000100000; //226 degrees
        #15 target_angle = 20'b00000000111000110000; //227 degrees
        #15 target_angle = 20'b00000000111001000000; //228 degrees
        #15 target_angle = 20'b00000000111001010000; //229 degrees
        #15 target_angle = 20'b00000000111001100000; //230 degrees
        #15 target_angle = 20'b00000000111001110000; //231 degrees
        #15 target_angle = 20'b00000000111010000000; //232 degrees
        #15 target_angle = 20'b00000000111010010000; //233 degrees
        #15 target_angle = 20'b00000000111010100000; //234 degrees
        #15 target_angle = 20'b00000000111010110000; //235 degrees
        #15 target_angle = 20'b00000000111011000000; //236 degrees
        #15 target_angle = 20'b00000000111011010000; //237 degrees
        #15 target_angle = 20'b00000000111011100000; //238 degrees
        #15 target_angle = 20'b00000000111011110000; //239 degrees
        #15 target_angle = 20'b00000000111100000000; //240 degrees
        #15 target_angle = 20'b00000000111100010000; //241 degrees
        #15 target_angle = 20'b00000000111100100000; //242 degrees
        #15 target_angle = 20'b00000000111100110000; //243 degrees
        #15 target_angle = 20'b00000000111101000000; //244 degrees
        #15 target_angle = 20'b00000000111101010000; //245 degrees
        #15 target_angle = 20'b00000000111101100000; //246 degrees
        #15 target_angle = 20'b00000000111101110000; //247 degrees
        #15 target_angle = 20'b00000000111110000000; //248 degrees
        #15 target_angle = 20'b00000000111110010000; //249 degrees
        #15 target_angle = 20'b00000000111110100000; //250 degrees
        #15 target_angle = 20'b00000000111110110000; //251 degrees
        #15 target_angle = 20'b00000000111111000000; //252 degrees
        #15 target_angle = 20'b00000000111111010000; //253 degrees
        #15 target_angle = 20'b00000000111111100000; //254 degrees
        #15 target_angle = 20'b00000000111111110000; //255 degrees
        #15 target_angle = 20'b00000001000000000000; //256 degrees
        #15 target_angle = 20'b00000001000000010000; //257 degrees
        #15 target_angle = 20'b00000001000000100000; //258 degrees
        #15 target_angle = 20'b00000001000000110000; //259 degrees
        #15 target_angle = 20'b00000001000001000000; //260 degrees
        #15 target_angle = 20'b00000001000001010000; //261 degrees
        #15 target_angle = 20'b00000001000001100000; //262 degrees
        #15 target_angle = 20'b00000001000001110000; //263 degrees
        #15 target_angle = 20'b00000001000010000000; //264 degrees
        #15 target_angle = 20'b00000001000010010000; //265 degrees
        #15 target_angle = 20'b00000001000010100000; //266 degrees
        #15 target_angle = 20'b00000001000010110000; //267 degrees
        #15 target_angle = 20'b00000001000011000000; //268 degrees
        #15 target_angle = 20'b00000001000011010000; //269 degrees
        #15 target_angle = 20'b00000001000011100000; //270 degrees
        #15 target_angle = 20'b00000001000011110000; //271 degrees
        #15 target_angle = 20'b00000001000100000000; //272 degrees
        #15 target_angle = 20'b00000001000100010000; //273 degrees
        #15 target_angle = 20'b00000001000100100000; //274 degrees
        #15 target_angle = 20'b00000001000100110000; //275 degrees
        #15 target_angle = 20'b00000001000101000000; //276 degrees
        #15 target_angle = 20'b00000001000101010000; //277 degrees
        #15 target_angle = 20'b00000001000101100000; //278 degrees
        #15 target_angle = 20'b00000001000101110000; //279 degrees
        #15 target_angle = 20'b00000001000110000000; //280 degrees
        #15 target_angle = 20'b00000001000110010000; //281 degrees
        #15 target_angle = 20'b00000001000110100000; //282 degrees
        #15 target_angle = 20'b00000001000110110000; //283 degrees
        #15 target_angle = 20'b00000001000111000000; //284 degrees
        #15 target_angle = 20'b00000001000111010000; //285 degrees
        #15 target_angle = 20'b00000001000111100000; //286 degrees
        #15 target_angle = 20'b00000001000111110000; //287 degrees
        #15 target_angle = 20'b00000001001000000000; //288 degrees
        #15 target_angle = 20'b00000001001000010000; //289 degrees
        #15 target_angle = 20'b00000001001000100000; //290 degrees
        #15 target_angle = 20'b00000001001000110000; //291 degrees
        #15 target_angle = 20'b00000001001001000000; //292 degrees
        #15 target_angle = 20'b00000001001001010000; //293 degrees
        #15 target_angle = 20'b00000001001001100000; //294 degrees
        #15 target_angle = 20'b00000001001001110000; //295 degrees
        #15 target_angle = 20'b00000001001010000000; //296 degrees
        #15 target_angle = 20'b00000001001010010000; //297 degrees
        #15 target_angle = 20'b00000001001010100000; //298 degrees
        #15 target_angle = 20'b00000001001010110000; //299 degrees
        #15 target_angle = 20'b00000001001011000000; //300 degrees
        #15 target_angle = 20'b00000001001011010000; //301 degrees
        #15 target_angle = 20'b00000001001011100000; //302 degrees
        #15 target_angle = 20'b00000001001011110000; //303 degrees
        #15 target_angle = 20'b00000001001100000000; //304 degrees
        #15 target_angle = 20'b00000001001100010000; //305 degrees
        #15 target_angle = 20'b00000001001100100000; //306 degrees
        #15 target_angle = 20'b00000001001100110000; //307 degrees
        #15 target_angle = 20'b00000001001101000000; //308 degrees
        #15 target_angle = 20'b00000001001101010000; //309 degrees
        #15 target_angle = 20'b00000001001101100000; //310 degrees
        #15 target_angle = 20'b00000001001101110000; //311 degrees
        #15 target_angle = 20'b00000001001110000000; //312 degrees
        #15 target_angle = 20'b00000001001110010000; //313 degrees
        #15 target_angle = 20'b00000001001110100000; //314 degrees
        #15 target_angle = 20'b00000001001110110000; //315 degrees
        #15 target_angle = 20'b00000001001111000000; //316 degrees
        #15 target_angle = 20'b00000001001111010000; //317 degrees
        #15 target_angle = 20'b00000001001111100000; //318 degrees
        #15 target_angle = 20'b00000001001111110000; //319 degrees
        #15 target_angle = 20'b00000001010000000000; //320 degrees
        #15 target_angle = 20'b00000001010000010000; //321 degrees
        #15 target_angle = 20'b00000001010000100000; //322 degrees
        #15 target_angle = 20'b00000001010000110000; //323 degrees
        #15 target_angle = 20'b00000001010001000000; //324 degrees
        #15 target_angle = 20'b00000001010001010000; //325 degrees
        #15 target_angle = 20'b00000001010001100000; //326 degrees
        #15 target_angle = 20'b00000001010001110000; //327 degrees
        #15 target_angle = 20'b00000001010010000000; //328 degrees
        #15 target_angle = 20'b00000001010010010000; //329 degrees
        #15 target_angle = 20'b00000001010010100000; //330 degrees
        #15 target_angle = 20'b00000001010010110000; //331 degrees
        #15 target_angle = 20'b00000001010011000000; //332 degrees
        #15 target_angle = 20'b00000001010011010000; //333 degrees
        #15 target_angle = 20'b00000001010011100000; //334 degrees
        #15 target_angle = 20'b00000001010011110000; //335 degrees
        #15 target_angle = 20'b00000001010100000000; //336 degrees
        #15 target_angle = 20'b00000001010100010000; //337 degrees
        #15 target_angle = 20'b00000001010100100000; //338 degrees
        #15 target_angle = 20'b00000001010100110000; //339 degrees
        #15 target_angle = 20'b00000001010101000000; //340 degrees
        #15 target_angle = 20'b00000001010101010000; //341 degrees
        #15 target_angle = 20'b00000001010101100000; //342 degrees
        #15 target_angle = 20'b00000001010101110000; //343 degrees
        #15 target_angle = 20'b00000001010110000000; //344 degrees
        #15 target_angle = 20'b00000001010110010000; //345 degrees
        #15 target_angle = 20'b00000001010110100000; //346 degrees
        #15 target_angle = 20'b00000001010110110000; //347 degrees
        #15 target_angle = 20'b00000001010111000000; //348 degrees
        #15 target_angle = 20'b00000001010111010000; //349 degrees
        #15 target_angle = 20'b00000001010111100000; //350 degrees
        #15 target_angle = 20'b00000001010111110000; //351 degrees
        #15 target_angle = 20'b00000001011000000000; //352 degrees
        #15 target_angle = 20'b00000001011000010000; //353 degrees
        #15 target_angle = 20'b00000001011000100000; //354 degrees
        #15 target_angle = 20'b00000001011000110000; //355 degrees
        #15 target_angle = 20'b00000001011001000000; //356 degrees
        #15 target_angle = 20'b00000001011001010000; //357 degrees
        #15 target_angle = 20'b00000001011001100000; //358 degrees
        #15 target_angle = 20'b00000001011001110000; //359 degrees
        #15 target_angle = 20'b00000001011010000000; //360 degrees
        
//            #15 target_angle = 20'b00000000000000000000; // 0 degrees
//            #15 target_angle = 20'b00000000000000010000; // 1 degrees
//            #15 target_angle = 20'b00000000000000100000; // 2 degrees
//            #15 target_angle = 20'b00000000000000110000; // 3 degrees
//            #15 target_angle = 20'b00000000000001000000; // 4 degrees
//            #15 target_angle = 20'b00000000000001010000; // 5 degrees
//            #15 target_angle = 20'b00000000000001100000; // 6 degrees
//            #15 target_angle = 20'b00000000000001110000; // 7 degrees
//            #15 target_angle = 20'b00000000000010000000; // 8 degrees
//            #15 target_angle = 20'b00000000000010010000; // 9 degrees
//            #15 target_angle = 20'b00000000000010100000; // 10 degrees
//            #15 target_angle = 20'b00000000000010110000; // 11 degrees
//            #15 target_angle = 20'b00000000000011000000; // 12 degrees
//            #15 target_angle = 20'b00000000000011010000; // 13 degrees
//            #15 target_angle = 20'b00000000000011100000; // 14 degrees
//            #15 target_angle = 20'b00000000000011110000; // 15 degrees
//            #15 target_angle = 20'b00000000000100000000; // 16 degrees
//            #15 target_angle = 20'b00000000000100010000; // 17 degrees
//            #15 target_angle = 20'b00000000000100100000; // 18 degrees
//            #15 target_angle = 20'b00000000000100110000; // 19 degrees
//            #15 target_angle = 20'b00000000000101000000; // 20 degrees
//            #15 target_angle = 20'b00000000000101010000; // 21 degrees
//            #15 target_angle = 20'b00000000000101100000; // 22 degrees
//            #15 target_angle = 20'b00000000000101110000; // 23 degrees
//            #15 target_angle = 20'b00000000000110000000; // 24 degrees
//            #15 target_angle = 20'b00000000000110010000; // 25 degrees            
//            #15 target_angle = 20'b00000000000110100000; // 26 degrees
//            #15 target_angle = 20'b00000000000110110000; // 27 degrees
//            #15 target_angle = 20'b00000000000111000000; // 28 degrees
//            #15 target_angle = 20'b00000000000111010000; // 29 degrees
//            #15 target_angle = 20'b00000000000111100000; // 30 degrees
//            #15 target_angle = 20'b00000000000111110000; // 31 degrees
//            #15 target_angle = 20'b00000000001000000000; // 32 degrees
//            #15 target_angle = 20'b00000000001000010000; // 33 degrees
//            #15 target_angle = 20'b00000000001000100000; // 34 degrees
//            #15 target_angle = 20'b00000000001000110000; // 35 degrees
//            #15 target_angle = 20'b00000000001001000000; // 36 degrees
//            #15 target_angle = 20'b00000000001001010000; // 37 degrees
//            #15 target_angle = 20'b00000000001001100000; // 38 degrees
//            #15 target_angle = 20'b00000000001001110000; // 39 degrees
//            #15 target_angle = 20'b00000000001010000000; // 40 degrees
//            #15 target_angle = 20'b00000000001010010000; // 41 degrees
//            #15 target_angle = 20'b00000000001010100000; // 42 degrees
//            #15 target_angle = 20'b00000000001010110000; // 43 degrees
//            #15 target_angle = 20'b00000000001011000000; // 44 degrees
//            #15 target_angle = 20'b00000000001011010000; // 45 degrees

//            #15 target_angle = 20'b00000000001011100000; // 46 degrees
//            #15 target_angle = 20'b00000000001011110000; // 47 degrees
//            #15 target_angle = 20'b00000000001100000000; // 48 degrees
//            #15 target_angle = 20'b00000000001100010000; // 49 degrees
//            #15 target_angle = 20'b00000000001100100000; // 50 degrees           
//            #15 target_angle = 20'b00000000001100110000; // 51 degrees
//            #15 target_angle = 20'b00000000001101000000; // 52 degrees
//            #15 target_angle = 20'b00000000001101010000; // 53 degrees
//            #15 target_angle = 20'b00000000001101100000; // 54 degrees
//            #15 target_angle = 20'b00000000001101110000; // 55 degrees
//            #15 target_angle = 20'b00000000001110000000; // 56 degrees
//            #15 target_angle = 20'b00000000001110010000; // 57 degrees
//            #15 target_angle = 20'b00000000001110100000; // 58 degrees
//            #15 target_angle = 20'b00000000001110110000; // 59 degrees
//            #15 target_angle = 20'b00000000001111000000; // 60 degrees
//            #15 target_angle = 20'b00000000001111010000; // 61 degrees
//            #15 target_angle = 20'b00000000001111100000; // 62 degrees
//            #15 target_angle = 20'b00000000001111110000; // 63 degrees
//            #15 target_angle = 20'b00000000010000000000; // 64 degrees
//            #15 target_angle = 20'b00000000010000010000; // 65 degrees
//            #15 target_angle = 20'b00000000010000100000; // 66 degrees
//            #15 target_angle = 20'b00000000010000110000; // 67 degrees
//            #15 target_angle = 20'b00000000010001000000; // 68 degrees
//            #15 target_angle = 20'b00000000010001010000; // 69 degrees
//            #15 target_angle = 20'b00000000010001100000; // 70 degrees
//            #15 target_angle = 20'b00000000010001110000; // 71 degrees
//            #15 target_angle = 20'b00000000010010000000; // 72 degrees
//            #15 target_angle = 20'b00000000010010010000; // 73 degrees
//            #15 target_angle = 20'b00000000010010100000; // 74 degrees
//            #15 target_angle = 20'b00000000010010110000; // 75 degrees
//            #15 target_angle = 20'b00000000010011000000; // 76 degrees
//            #15 target_angle = 20'b00000000010011010000; // 77 degrees
//            #15 target_angle = 20'b00000000010011100000; // 78 degrees
//            #15 target_angle = 20'b00000000010011110000; // 79 degrees
//            #15 target_angle = 20'b00000000010100000000; // 80 degrees
//            #15 target_angle = 20'b00000000010100010000; // 81 degrees
//            #15 target_angle = 20'b00000000010100100000; // 82 degrees
//            #15 target_angle = 20'b00000000010100110000; // 83 degrees
//            #15 target_angle = 20'b00000000010101000000; // 84 degrees
//            #15 target_angle = 20'b00000000010101010000; // 85 degrees
//            #15 target_angle = 20'b00000000010101100000; // 86 degrees
//            #15 target_angle = 20'b00000000010101110000; // 87 degrees
//            #15 target_angle = 20'b00000000010110000000; // 88 degrees
//            #15 target_angle = 20'b00000000010110010000; // 89 degrees
//            #15 target_angle = 20'b00000000010110100000; // 90 degrees
                        
//            #15 target_angle = 20'b00000000010110110000; // 91 degrees
//            #15 target_angle = 20'b00000000010111000000; // 92 degrees
//            #15 target_angle = 20'b00000000010111010000; // 93 degrees
//            #15 target_angle = 20'b00000000010111100000; // 94 degrees
//            #15 target_angle = 20'b00000000010111110000; // 95 degrees
//            #15 target_angle = 20'b00000000011000000000; // 96 degrees
//            #15 target_angle = 20'b00000000011000010000; // 97 degrees
//            #15 target_angle = 20'b00000000011000100000; // 98 degrees
//            #15 target_angle = 20'b00000000011000110000; // 99 degrees
//            #15 target_angle = 20'b00000000011001000000; // 100 degrees
//            #15 target_angle = 20'b00000000011001010000; // 101 degrees
//            #15 target_angle = 20'b00000000011001100000; // 102 degrees
//            #15 target_angle = 20'b00000000011001110000; // 103 degrees
//            #15 target_angle = 20'b00000000011010000000; // 104 degrees
//            #15 target_angle = 20'b00000000011010010000; // 105 degrees
//            #15 target_angle = 20'b00000000011010100000; // 106 degrees
//            #15 target_angle = 20'b00000000011010110000; // 107 degrees
//            #15 target_angle = 20'b00000000011011000000; // 108 degrees
//            #15 target_angle = 20'b00000000011011010000; // 109 degrees
//            #15 target_angle = 20'b00000000011011100000; // 110 degrees
//            #15 target_angle = 20'b00000000011011110000; // 111 degrees
//            #15 target_angle = 20'b00000000011100000000; // 112 degrees
//            #15 target_angle = 20'b00000000011100010000; // 113 degrees
//            #15 target_angle = 20'b00000000011100100000; // 114 degrees
//            #15 target_angle = 20'b00000000011100110000; // 115 degrees
//            #15 target_angle = 20'b00000000011101000000; // 116 degrees
//            #15 target_angle = 20'b00000000011101010000; // 117 degrees
//            #15 target_angle = 20'b00000000011101100000; // 118 degrees
//            #15 target_angle = 20'b00000000011101110000; // 119 degrees
//            #15 target_angle = 20'b00000000011110000000; // 120 degrees
//            #15 target_angle = 20'b00000000011110010000; // 121 degrees
//            #15 target_angle = 20'b00000000011110100000; // 122 degrees
//            #15 target_angle = 20'b00000000011110110000; // 123 degrees
//            #15 target_angle = 20'b00000000011111000000; // 124 degrees
//            #15 target_angle = 20'b00000000011111010000; // 125 degrees
//            #15 target_angle = 20'b00000000011111100000; // 126 degrees
//            #15 target_angle = 20'b00000000011111110000; // 127 degrees
//            #15 target_angle = 20'b00000000100000000000; // 128 degrees
//            #15 target_angle = 20'b00000000100000010000; // 129 degrees
//            #15 target_angle = 20'b00000000100000100000; // 130 degrees
//            #15 target_angle = 20'b00000000100000110000; // 131 degrees
//            #15 target_angle = 20'b00000000100001000000; // 132 degrees
//            #15 target_angle = 20'b00000000100001010000; // 133 degrees
//            #15 target_angle = 20'b00000000100001100000; // 134 degrees
//            #15 target_angle = 20'b00000000100001110000; // 135 degrees
//            #15 target_angle = 20'b00000000100010000000; // 136 degrees
//            #15 target_angle = 20'b00000000100010010000; // 137 degrees
//            #15 target_angle = 20'b00000000100010100000; // 138 degrees
//            #15 target_angle = 20'b00000000100010110000; // 139 degrees
//            #15 target_angle = 20'b00000000100011000000; // 140 degrees
//            #15 target_angle = 20'b00000000100011010000; // 141 degrees
//            #15 target_angle = 20'b00000000100011100000; // 142 degrees
//            #15 target_angle = 20'b00000000100011110000; // 143 degrees
//            #15 target_angle = 20'b00000000100100000000; // 144 degrees
//            #15 target_angle = 20'b00000000100100010000; // 145 degrees
//            #15 target_angle = 20'b00000000100100100000; // 146 degrees
//            #15 target_angle = 20'b00000000100100110000; // 147 degrees
//            #15 target_angle = 20'b00000000100101000000; // 148 degrees
//            #15 target_angle = 20'b00000000100101010000; // 149 degrees
//            #15 target_angle = 20'b00000000100101100000; // 150 degrees
            
//            #15 target_angle = 20'b00000000101101000000; // 180 degrees
//            #15 target_angle = 20'b00000000101101010000; // 181 degrees
               
        $fclose(fh_cos);
        $fclose(fh_sin);
       #20 $finish;
     end
endmodule
