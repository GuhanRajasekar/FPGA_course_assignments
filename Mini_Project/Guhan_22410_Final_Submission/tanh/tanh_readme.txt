Here the top file is "cordic_tanh.v" and the corresponding test bench file is "cordic_tanh_tb.v" .


To get the simulation waveforms in vivado, the following format must be specified for the input and the output signals:

input(target_angle) => 10 bits for integer and 10 bits for fractional
output(tanh)        => 10 bits for integer and 10 bits for fractional

The above proper format can be implemented by :
  1). Right click on the signal in vivado simulation.
  2). Real -> Real Settings -> Fixed Point -> Signed -> Enter the number of bits from the LSB end after which the binary point must be present (Also equal to the number of bits allocated for the fractional part in the input format)

