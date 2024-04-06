import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

file_loc = "F:\PhD_IISc\Coursework\Jan_2024\FPGA\FPGA_course_assignments\Mini_Project\Source_Code\Data\\cos_data.txt"
fh = pd.read_csv(file_loc,delim_whitespace=True,skiprows=2,header=None,dtype=str)

cos_values_binary = fh[:][0].to_numpy()
cos_values_decimal = np.zeros(len(cos_values_binary))

for i in range(len(cos_values_binary)):
    cos_values_decimal[i] = int(cos_values_binary[i],2)
    if (cos_values_binary[i][0] == '1'):
        cos_values_decimal[i] = -(2**20 - cos_values_decimal[i])

cos_values_decimal = cos_values_decimal/(2**16)

y_input = fh[:][1].to_numpy().astype(int)
y_input = y_input/(2**4)

plt.figure()
plt.clf()
plt.plot(y_input,cos_values_decimal,'o-')
plt.xlabel("x (degrees)")
plt.ylabel("cos(x)")
plt.title("cos Function")
plt.savefig(file_loc[:-3]+"png")
plt.savefig(file_loc[:-3]+"pdf")
plt.show()

