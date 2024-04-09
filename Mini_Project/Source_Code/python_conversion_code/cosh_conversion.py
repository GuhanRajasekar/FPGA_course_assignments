import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

file_loc = "F:\PhD_IISc\Coursework\Jan_2024\FPGA\FPGA_course_assignments\Mini_Project\Source_Code\Data\cosh_data.txt"
fh = pd.read_csv(file_loc,delim_whitespace=True,skiprows=3,header=None,dtype=str)

cosh_values_binary = fh[:][0].to_numpy()
cosh_values_decimal = np.zeros(len(cosh_values_binary))
for i in range(len(cosh_values_binary)):
    cosh_values_decimal[i] = int(cosh_values_binary[i],2)

cosh_values_decimal = cosh_values_decimal/(2**16)

target_angle = fh[:][1].to_numpy().astype(int)
target_angle = target_angle/(2**16)

# indices to plot
# 0, 4,11,18,26,33,40,48,55,58,61,68,76,83,90,98,105,112
# ind_to_plot = [0, 4,11,18,26,33,40,48,55,58,61,68,76,83,90,98,105,112]
ind_to_plot = []
for i in range(len(cosh_values_decimal)):
    if(cosh_values_decimal[i-1]!=cosh_values_decimal[i]):
        ind_to_plot.append(i)

plt.figure()
plt.clf()
plt.plot(target_angle[ind_to_plot],cosh_values_decimal[ind_to_plot],'o-')
# plt.plot(target_angle,cosh_values_decimal,'o-')
plt.plot(np.linspace(target_angle[0],target_angle[-1],100),np.cosh(np.linspace(target_angle[0],target_angle[-1],100)))
plt.xlabel("x (Radians)")
plt.ylabel("Cosh(x)")
plt.title("Cos Hyperbolic Function")
plt.savefig(file_loc[:-3]+"png")
plt.savefig(file_loc[:-3]+"pdf")
plt.show()


