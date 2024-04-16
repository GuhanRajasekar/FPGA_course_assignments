To view the waveforms in vivado, the following format needs to be followed for the input and output waveforms:

input (y)                        = 16 bits for the integer part and 4 bits for the fractional part
output (z = tan inverse [y])     = 16 bits for the integer part and 4 bits for the fractional part

The above proper format can be implemented by :
  1). Right click on the signal in vivado simulation.
  2). Real -> Real Settings -> Fixed Point -> Signed -> Enter the number of bits from the LSB end after which the binary point must be present (Also equal to the number of bits allocated for the fractional part in the input format)