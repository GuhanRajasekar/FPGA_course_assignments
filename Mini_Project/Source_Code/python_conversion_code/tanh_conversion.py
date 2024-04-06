import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

file_loc = "F:\PhD_IISc\Coursework\Jan_2024\FPGA\FPGA_course_assignments\Mini_Project\Source_Code\Data\\tanh_data.txt"
fh = pd.read_csv(file_loc,delim_whitespace=True,skiprows=2,header=None,dtype=str)

tanh_values_binary = fh[:][0].to_numpy()
tanh_values_decimal = np.zeros(len(tanh_values_binary))

for i in range(len(tanh_values_binary)):
    tanh_values_decimal[i] = int(tanh_values_binary[i],2)
    if (tanh_values_binary[i][0] == '1'):
        tanh_values_decimal[i] = -(2**32 - tanh_values_decimal[i])

tanh_values_decimal = tanh_values_decimal/(2**16)

y_input = fh[:][1].to_numpy().astype(int)
y_input = y_input/(2**16)

plt.figure()
plt.clf()
plt.plot(y_input,tanh_values_decimal,'o-')
plt.xlabel("x (degrees)")
plt.ylabel("tanh(x)")
plt.title("tanh Function")
plt.savefig(file_loc[:-3]+"png")
plt.savefig(file_loc[:-3]+"pdf")
plt.show()

