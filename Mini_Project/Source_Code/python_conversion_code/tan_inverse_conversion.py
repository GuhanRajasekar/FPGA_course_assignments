import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

file_loc = "F:\PhD_IISc\Coursework\Jan_2024\FPGA\FPGA_course_assignments\Mini_Project\Source_Code\Data\\tan_inv_data.txt"
fh = pd.read_csv(file_loc,delim_whitespace=True,skiprows=2,header=None,dtype=str)

tan_inv_values_binary = fh[:][0].to_numpy()
tan_inv_values_decimal = np.zeros(len(tan_inv_values_binary))

for i in range(len(tan_inv_values_binary)):
    tan_inv_values_decimal[i] = int(tan_inv_values_binary[i],2)
    if (tan_inv_values_binary[i][0] == '1'):
        tan_inv_values_decimal[i] = -(2**20 - tan_inv_values_decimal[i])

tan_inv_values_decimal = tan_inv_values_decimal/(2**4)

y_input = fh[:][1].to_numpy().astype(int)
y_input = y_input/(2**4)

plt.figure()
plt.clf()
plt.plot(y_input,tan_inv_values_decimal,'o-')
plt.xlabel("x (Real value)")
plt.ylabel("Angle (degrees)")
plt.title("Tan inverse Function")
plt.savefig(file_loc[:-3]+"png")
plt.savefig(file_loc[:-3]+"pdf")
plt.show()

