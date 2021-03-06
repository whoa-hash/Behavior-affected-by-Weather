#!/usr/bin/gawk -f

#we need this file for the date and the sev diff
#later on we can do #get the weather data field
                    #if the date is in the EMS date file (or date array?)
                    #get the weather niceness field
                    # save the date and weather niceness together
BEGIN{
    FS = "|"
#get the initial severity codes alone
#we use the NYC_EMS_Incidents file
    command = "zcat "
    file = "/data/raw/NYC_EMS_Incidents/EMS_Incident_Dispatch_Data.tsv.gz"
    #let's see if we're getting the correct amount of records
    count = 0
    numOutput = 0
    while ((command file | getline)>0){
	count += 1
	
	#we don't need the first line
	if (count == 1)
	    continue
	line = $0
	# since the weather data for dates only goes until 2019
	# we won't be able to get the weather for the 2020 EMS calls
	# so let's just stop there
	
	everything = split(line, array, "\t")
	
	datetime = array[2]
	if (datetime ~ /[/]2020/)
	    continue
	
	# let's fix the date to match the weather data dates
	date = substr(datetime, 1,11)
	hour = substr(datetime, 12, 2)
	minutes = substr(datetime, 15, 2)
	am = substr(datetime, length(datetime)-1)
	# get the hour and mins of the EMS date and round up or down
	# to the nearest hour
	if (int(minutes) >= 30){
	   hour = int(hour)
	   # special case for 12 AM
	   if (hour == 12)
	       hour = 1
	   else{
	   # special case for i.e.11:59 PM to 12 AM
	       if ((hour == 11) && (am == "PM"))
		  am = "AM"
	       else if ((hour == 11) && (am == "AM"))
		  am = "PM"
	       hour = hour + 1
		}
	   # if the hour is a single digit put a zero before the digit
	   if (hour < 10)
	       hour = "0"hour
	   }

	# if the mins are less than 30 we'll just keep the number as is
	
	time = hour":00:00 "am
	datehour = date time

	#the 4the item is the initial call severity
	#the 6th item is the final call severity
	initial = array[4]
	final = array[6]
	difference = final - initial
	#if we want to skip the zero severity codes bc they pull our average
	#to zero, we can do
	if (int(difference) == 0)
	    continue
	numOutput++
	if ((count % 100000) == 0)
	    print "Processed", count, "records. Number output:", numOutput > "/dev/stderr"
	print datehour, difference > "EMS_matches_weathr_dateAND_sev_code_diff.txt"	
    }
    print "Successfully processed this many records:", count, "and actually output", numOutput > "/dev/stderr"
    
}
