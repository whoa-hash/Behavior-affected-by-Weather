#!/usr/bin/env python3

import matplotlib.pyplot as plt
import random
import math

# create the figure instance to be written to a PDF
figure = plt.figure()

#make the list of points to be plotted
# so we're going to use the weather rate and sev text file
file = "average_for_plot_data.txt"
# the file has points like this i.e. 0.0 -.0100003343
# the 0.0 is the weather rate and the -.01.. is the sev diff average
f = open(file)
line = f.readline()
#let's keep an array for each line
array = []
weather_rate = ""
x = []
sev_code_diff = ""
y = []
# let's make the weather rate the x axis
# read each line from the file
while line:
    # this will give us i.e. ['0.0', '-.001'] in which
    # the weather rate is the first number and the
    # sev code diff average is the second
    array = line.split()
    # get the weather rate
    weather_rate = float(array[0])
    # add that number to the x axis list
    x.append(weather_rate)
    # and the sev code diff the y axis
    # get the sev code diff
    sev_code_diff = float(array[1])
    # add that number to the y axis list
    y.append(sev_code_diff)

    #go to the next line
    line = f.readline()
f.close()

# make the scatter plot
plt.plot(x, y, 'ro')

# specify the x and y labels
plt.xlabel("Weather Condition Rating from Best to Worst Weather")
plt.ylabel("EMS Calls Exaggeration AVERAGE")
plt.title("Exaggeration of EMS Calls\nfrom Best to Worst Weather")
#make the y axis go from greatest to least upward
plt.gca().invert_yaxis()

figure.savefig("graph_inclementWeather_EMScalls.pdf")
