`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2023 00:15:11
// Design Name: 
// Module Name: LED_DISPLAY
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


// fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// FPGA tutorial: seven-segment LED display controller on Basys  3 FPGA
module board_interface(
    input clock_100Mhz, // 100 Mhz clock source on Basys 3 FPGA
    input reset, // reset
    input [14:0] sw,
    output reg [3:0] an, // anode signals of the 7-segment LED display
    output reg [0:6] seg,// cathode patterns of the 7-segment LED displa
    output  [3:0] JB
    );
    wire [7:0] sine_out,cosine_out;
    wire [15:0] s_out,c_out;
    wire css;
    
    waveform_generator wg1(
    .clk(clock_100Mhz),
    .frequency({1'b0,sw}),
    .reset(reset),
    .sine(sine_out),
    .cosine(cosine_out)
    );
     interface_wg_dac wd(
    .rst(reset),
    .sine(sine_out),
    .cosine(cosine_out),
    .pulse(css),
    .clk(clock_100Mhz),
    .out_sine(s_out),
    .out_cosine(c_out)
    );
    
    pmodDAC dac(
    .clock100Mhz(clock_100Mhz),
    .sine_data(s_out),
    .cosine_data(c_out),
    .rst(reset),
    .SCLK(JB[3]),
    .SDATA1(JB[1]),
    .SDATA2(JB[2]),
    .NSYNC(JB[0])
    );
    
    
    wire [14:0] slider;
    reg [26:0] one_second_counter; // counter for generating 1 second clock enable
    wire [15:0] number;// one second enable for counting numbers
    reg [14:0] displayed_number; // counting number to be displayed
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter; // 20-bit for creating 10.5ms refresh period or 380Hz refresh rate
             // the first 2 MSB bits for creating 4 LED-activating signals with 2.6ms digit period
    wire [1:0] LED_activating_counter; 
                 // count     0    ->  1  ->  2  ->  3
              // activates    LED1    LED2   LED3   LED4
             // and repeat
             assign slider = sw;
   // slider_switch ss(clock_100Mhz,slider,number);     
    always @(posedge clock_100Mhz or posedge reset)
    begin
        if(reset==1)
            displayed_number <= 0;
        else 
            displayed_number <= sw;
    end
    always @(posedge clock_100Mhz or posedge reset)
    begin 
        if(reset==1)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end 
    assign LED_activating_counter = refresh_counter[19:18];
    // anode activating signals for 4 LEDs, digit period of 2.6ms
    // decoder to generate anode signals 
    always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            an = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = displayed_number/1000;
            // the first digit of the 16-bit number
              end
        2'b01: begin
            an = 4'b1011; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = (displayed_number % 1000)/100;
            // the second digit of the 16-bit number
              end
        2'b10: begin
            an = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = ((displayed_number % 1000)%100)/10;
            // the third digit of the 16-bit number
                end
        2'b11: begin
            an = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = ((displayed_number % 1000)%100)%10;
            // the fourth digit of the 16-bit number    
               end
        endcase
    end
    // Cathode patterns of the 7-segment LED display 
    always @(*)
    begin
        case(LED_BCD)
        4'b0000: seg = 7'b0000001; // "0"     
        4'b0001: seg = 7'b1001111; // "1" 
        4'b0010: seg = 7'b0010010; // "2" 
        4'b0011: seg = 7'b0000110; // "3" 
        4'b0100: seg = 7'b1001100; // "4" 
        4'b0101: seg = 7'b0100100; // "5" 
        4'b0110: seg = 7'b0100000; // "6" 
        4'b0111: seg = 7'b0001111; // "7" 
        4'b1000: seg = 7'b0000000; // "8"     
        4'b1001: seg = 7'b0000100; // "9" 
        default: seg = 7'b0000001; // "0"
        endcase
    end
 endmodule
