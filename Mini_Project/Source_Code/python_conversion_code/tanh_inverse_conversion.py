import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

file_loc = "F:\PhD_IISc\Coursework\Jan_2024\FPGA\FPGA_course_assignments\Mini_Project\Source_Code\Data\\tanh_inv_data.txt"
fh = pd.read_csv(file_loc,delim_whitespace=True,skiprows=2,header=None,dtype=str)

tanh_inv_values_binary = fh[:][0].to_numpy()
tanh_inv_values_decimal = np.zeros(len(tanh_inv_values_binary))

for i in range(len(tanh_inv_values_binary)):
    tanh_inv_values_decimal[i] = int(tanh_inv_values_binary[i],2)
    if (tanh_inv_values_binary[i][0] == '1'):
        tanh_inv_values_decimal[i] = -(2**20 - tanh_inv_values_decimal[i])

tanh_inv_values_decimal = tanh_inv_values_decimal/(2**14)

y_input = fh[:][1].to_numpy().astype(int)
y_input = y_input/(2**16)

plt.figure()
plt.clf()
plt.plot(y_input,tanh_inv_values_decimal,'o-')
plt.xlabel("x (Real value)")
plt.ylabel(" $tan^{-1}(x)$")
plt.title("Tan hyperbolic inverse Function")
plt.savefig(file_loc[:-3]+"png")
plt.savefig(file_loc[:-3]+"pdf")
plt.show()

