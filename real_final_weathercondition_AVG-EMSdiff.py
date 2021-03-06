#!/usr/bin/env python3
import sys

# use the text file that has weather condition and sev code diff like
# i.e. 0, -4 where 0 is the   "     "    "and -4 is the sev code difference

file = "final_weatherRate_AND_severity.txt"
f = open(file)
line = f.readline()

# this will be our dict. for each weather condition's array of severity diff's
AVG = {}
sev_code_diff = ""
weather_condition = ""
# for each weather condition get the average EMS sev code difference

# go through each line in the file
while line:
  array = line.split() # this gives us something like this i.e. ['0','1']
  # get the weather condition
  weather_condition = float(array[0])
 
  # get the sev code difference
  sev_code_diff = float(array[1])
  # use the weather condition as the dictionary key for an array of differences
  # if the key is not in the dict yet
  if weather_condition not in AVG:
      # add it to the dict with a list of the sev code
      AVG[weather_condition] = [sev_code_diff]
  # if it is in the dict already
  else:
     #append the sev code to the key's array
      AVG[weather_condition].append(sev_code_diff)
  # in the severity code
  # i.e. AVG[0] = [1,2,-8, 0..]
  line = f.readline()
f.close()


# let's hold these to compute the average
total = 0
numbers = 0
#open the file so that the (i, avg) gets printed to it
sys.stdout = open("average_for_plot_data.txt", "w")
for i in AVG:
   numbers = len(AVG[i])
   total = sum(AVG[i])
   avg = total/numbers
   print(i, avg)
   
   
   
   # close it from writing
sys.stdout.close()
