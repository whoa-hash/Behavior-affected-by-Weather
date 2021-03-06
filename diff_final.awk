#!/usr/bin/gawk -f
# need to run niceness_date_with_function.awk before running this file
# so that you have proper weather and severity codes
BEGIN{
  # - a file with the weather description and the rating
  file1 = "weather_description_rating_this_one.txt"
  # - a file with the weather description and the severity code difference
  file2 = "weather_descriptionANDsev_diff.txt"
# go through the the weather description and rating text file
  while ((getline < file1) >0){
      weather_description = ""
      line = $0
      split(line, arr)
      # get the rating, which will be in the first spot in the array
      rating = arr[1]
      # get the weather, which will be the rest of the spots in the array
      for (i = 2; i<= length(arr); i++){
	  # if this is the first weather description name we're up to
	  # we don't need a space before the name
	  if (i == 2)
	      weather_description = arr[i]
	  # but if we're up to the 2nd word (snow) in i.e. light snow
	  # we want to put a space after the word i.e. light
	  else
	      weather_description = weather_description" "arr[i]
      }
      # put the weather in an array like so i.e. weather[description] = rating
      weather[weather_description] = rating
  }
  # this will tell us when it's on the first line
  count = 0
  # go through the weather description and sev code diff file
  while ((getline < file2) >0){
      count +=1
      line = $0
      # we don't need the first line
      if (count == 1)
	  continue
      #get the weather
      weather_description = substr(line, 4)
   
      #get the severity code difference from final code severity minus the initial
      sev_code_diff = substr(line, 1, 2)
      # so sev_code_diff output will either be i.e. " 0" or "-1"
      # and we don't want the extra space so let's take it away

      # this is a line we don't need
      if (sev_code_diff ~/M/)
	  break
  
      sev_code_diff = int(sev_code_diff)
      print("Record", count"'s severity code: "sev_code_diff)
	  

      #if the weather description is in the weather array (it should be)
      if (weather_description in weather != 0)
	  # print the weather rating, sev code diff
	  print weather[weather_description],sev_code_diff > "final_weatherRate_AND_severity.txt"
      # if it's not in the weather description array
      # we don't care about that, because every kind of weather will for sure be in the array
  }
  
}
