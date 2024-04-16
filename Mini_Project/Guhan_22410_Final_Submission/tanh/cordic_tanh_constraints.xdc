create_clock -period 30.000 -name clk -waveform {0.000 15.000} [get_ports clk]
set_input_delay -clock [get_clocks clk] -min -add_delay 0.200 [get_ports {target_angle[*]}]
set_input_delay -clock [get_clocks clk] -max -add_delay 0.200 [get_ports {target_angle[*]}]
set_input_delay -clock [get_clocks clk] -min -add_delay 0.200 [get_ports rst]
set_input_delay -clock [get_clocks clk] -max -add_delay 0.200 [get_ports rst]

