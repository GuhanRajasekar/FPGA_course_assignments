create_clock -period 100.000 -name clk -waveform {0.000 50.000} [get_ports clk]
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports {target_angle[*]}]
set_input_delay -clock [get_clocks clk] -max -add_delay 3.000 [get_ports {target_angle[*]}]
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports rst]
set_input_delay -clock [get_clocks clk] -max -add_delay 3.000 [get_ports rst]
set_output_delay -clock [get_clocks clk] -min -add_delay -1.000 [get_ports {x_res[*]}]
set_output_delay -clock [get_clocks clk] -max -add_delay 2.000 [get_ports {x_res[*]}]
set_output_delay -clock [get_clocks clk] -min -add_delay -1.000 [get_ports {y_res[*]}]
set_output_delay -clock [get_clocks clk] -max -add_delay 2.000 [get_ports {y_res[*]}]



