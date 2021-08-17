#!/usr/bin/gawk -f

function change_dateFormat(line, date, year, month, day, newdate, time){
	
        #split the line into fields
	split(line, arr, "|")
	#get the date which is in field 1 which we will use as a key for
	# the array i.e. weather[datetime] = niceness
	date = arr[2]
	
	# switch the format of the date from i.e.
	#2011-09-07 to 09/07/2011
	year = substr(date, 1, 4)
	month = substr(date,6, 2)
	day = substr(date, 9, 2)
	newdate = month"/"day"/"year

	# time to switch the format of the time!
	time = substr(date, 12, length(date)-14)
	
	print newdate,time "is"
	#make the time regular time so
	hour = substr(time, 1,2)

	if (int(hour) < 12){
	    if (hour == "00"){
		# this hour needs to be converted
		hour = "12"
		line = newdate" "hour substr(time,3)"AM"
	    }
	    else{
		
		# but all the other AM times can stay the same
		line = newdate" "time"AM"
	    }
	}
	else if (int(hour) > 12){
	    # the PM hours need to be converted
	    hour = int(hour) - 12
	    # need to add a 0 for the single digit numbers (#'s less than 10)
	    if ((int(hour) == 10) || (int(hour) == 11)){
		line = newdate" "hour substr(time,3)"PM"
	    }
	    else
		line = newdate" 0"hour substr(time,3)"PM"
	    }
	else if (int(hour) == 12){
	    # this is for 12 PM
	    line = newdate" "time"PM"
	}
	
	return line
}
#go through the weather data gz file
BEGIN{
    FS = "|"
    command = "zcat "
    file = "/data/raw/historicalWeather/manhattanHistoricalWeather/manhattanWeatherClean.gz"
    #let's keep track of the records
    count = 0
    while ((command file | getline) > 0){
	
	# get the weather niceness and date for that line
	line = $0
	split(line, arr, "|")

	niceness = arr[32]
	date_time = change_dateFormat(line)
	# we don't need dates less than 2005 because the EMS dates only start at
	#2005. The weather data starts at 2002
	if (date_time ~ /[/]200[2-4]/)
	    continue
	
	#make an array
	#weather[datetime] = weather description
	print date_time"done with the weather"
	weather[date_time] = niceness
	
    }
    EMS_file = "EMS_matches_weathr_dateAND_sev_code_diff.txt"
    #go through the EMS dates and severity codes diff text file
    while (("cat " EMS_file | getline) >0){
	
	count += 1
	if ((count % 100000) == 0)
	    print "Processed", count > "/dev/stderr"
	line = $0
	#get the EMS call date
	date = substr(line, 1, length(line)-2)
	
	#if the date is from 12/11/2019 and on then skip it bec we don't
	#have those dates in the weather file
	if (date ~ /12[/][1-3][1-9][/]2019/)
	    continue
	else if (date ~ /12[/][2-3][0][/]2019/)
	    continue
	
	#get the EMS difference in severity for that date
	difference = substr(line, length(line)-1)
	sub(/[ \t]+$/, "", date)
	#if the date is in the weather file i.e. in the array
	#(if it's not, we ignore the dates because they're a minimal amount)
	if (date in weather != 0){
	  # get the weather on that EMS call date
	    EMS_weather = weather[date]   
            #output severity code diff and weather niceness for that date
	    print difference " " EMS_weather  > "weather_descriptionANDsev_diff.txt"
	}
	
    print "Successfully processed " count, "records."
    }
}
