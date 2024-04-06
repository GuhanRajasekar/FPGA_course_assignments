import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

file_loc = "F:\PhD_IISc\Coursework\Jan_2024\FPGA\FPGA_course_assignments\Mini_Project\Source_Code\Data\\tan_data.txt"
fh = pd.read_csv(file_loc,delim_whitespace=True,skiprows=1,header=None,dtype=str)

tan_values_binary = fh[1::2][0].to_numpy()
tan_values_decimal = np.zeros(len(tan_values_binary))

for i in range(len(tan_values_binary)):
    tan_values_decimal[i] = int(tan_values_binary[i],2)
    if (tan_values_binary[i][0] == '1'):
        tan_values_decimal[i] = -(2**20 - tan_values_decimal[i])

tan_values_decimal = tan_values_decimal/(2**16)

y_input = fh[1::2][1].to_numpy().astype(int)
y_input = y_input/(2**4)
for i in range(len(y_input)):
    if (y_input[i]>90):
        y_input[i] = 360 - y_input[i]

plt.figure()
plt.clf()
plt.plot(y_input,tan_values_decimal,'o-')
plt.xlabel("x (degrees)")
plt.ylabel("tan(x)")
plt.title("tan Function")
plt.savefig(file_loc[:-3]+"png")
plt.savefig(file_loc[:-3]+"pdf")
plt.show()

