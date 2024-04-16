The following format must be used for input and output signals to get proper waveforms in vivado simulations:

y(input) => 16 bits for the fractional part and 4 bits for the integer part
z(output) => tanh inverse (y) = 14 bits for the fractional part and 6 bits for the integer part

The above proper format can be implemented by :
  1). Right click on the signal in vivado simulation.
  2). Real -> Real Settings -> Fixed Point -> Signed -> Enter the number of bits from the LSB end after which the binary point must be present (Also equal to the number of bits allocated for the fractional part in the input format)