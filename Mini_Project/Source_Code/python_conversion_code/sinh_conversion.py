import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

file_loc = "F:\PhD_IISc\Coursework\Jan_2024\FPGA\FPGA_course_assignments\Mini_Project\Source_Code\Data\sinh_data.txt"
fh = pd.read_csv(file_loc,delim_whitespace=True,skiprows=2,header=None,dtype=str)

sinh_values_binary = fh[:][0].to_numpy()
sinh_values_decimal = np.zeros(len(sinh_values_binary))
for i in range(len(sinh_values_binary)):
    sinh_values_decimal[i] = int(sinh_values_binary[i],2)
    if (sinh_values_binary[i][0] == '1'):
        sinh_values_decimal[i] = -(2**32 - sinh_values_decimal[i])

sinh_values_decimal = sinh_values_decimal/(2**16)

target_angle = fh[:][1].to_numpy().astype(int)
target_angle = target_angle/(2**16)
# indices to plot
# 0, 4,11,18,26,33,40,48,55,58,61,68,76,83,90,98,105,112
ind_to_plot = [0, 4,11,18,26,33,40,48,55,58,61,68,76,83,90,98,105,112]

plt.figure()
plt.clf()
plt.plot(target_angle,sinh_values_decimal,'o-')
# plt.plot(target_angle[ind_to_plot],sinh_values_decimal[ind_to_plot],'o-')
plt.plot(np.linspace(target_angle[0],target_angle[-1],100),np.sinh(np.linspace(target_angle[0],target_angle[-1],100)))
plt.xlabel("x (Radians)")
plt.ylabel("sinh(x)")
plt.title("Sin Hyperbolic Function")
plt.savefig(file_loc[:-3]+"png")
plt.savefig(file_loc[:-3]+"pdf")
plt.show()


