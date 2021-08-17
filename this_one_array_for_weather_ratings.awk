#!/usr/bin/gawk -f
#the weather options

# gives the weather a rating from 0 - 12 where 0 is the weather that is nicest and 12 is the 'worst'
function give_rating(niceness){
    if (niceness == "sky is clear")
	rating = 0
    else if (niceness == "few clouds" || niceness == "scattered clouds")
	rating = 1
    else if (niceneness == "broken clouds")
	rating = 2
    else if (niceness == "overcast clouds")
	rating = 2.8
    else if (niceness == "drizzle" || niceness == "shower drizzle" ||
	     niceness == "light intensity drizzle")
	rating = 3.2
    else if (niceness == "mist")
	rating = 3.1
    else if (niceness == "haze" || niceness == "smoke")
	rating = 3
    else if (niceness == "light rain")
	rating = 3.3
    else if (niceness == "proximity squalls")
	rating = 5
    else if (niceness == "fog")
	rating = 4
    else if (niceness == "light intensity shower rain" ||
	     niceness == "shower rain" ||
	     niceness == "proximity thunderstorm")
	rating = 6
    else if (niceness == "moderate rain")
	rating = 6.5
    else if (niceness == "extreme rain" ||
	     niceness == "heavy intensity rain" ||
	     niceness == "heavy intesity shower rain")
	rating = 7
    else if (niceness == "freezing rain")
	rating = 8
    else if (niceness == "snow" || niceness == "light snow" ||
	     niceness == "light rain and snow")
	rating = 7.4
    else if (niceness == "heavy snow" || niceness == "very heavy rain")
	rating = 10
    else if (niceness == "thunderstorm")
	rating = 9
    else if (niceness == "thunderstorm with light rain" ||
	     niceness == "thunderstorm with rain")
	rating = 10.5
    else if (niceness == "thunderstorm with heavy rain")
	rating = 11
    else if (niceness == "squalls")
	rating = 12
    return rating
}

BEGIN {
    FS = "|"
    command = "zcat "
    file = "/data/raw/historicalWeather/manhattanHistoricalWeather/manhattanWeatherClean.gz"
    # keep this count so that you have the key for each weather description
    count = 0
    #go through the weather file
    while ((command file | getline) > 0){
	count += 1
	line = $0
	# the first line is not needed
	if (line ~ /weather_description/)
	    continue
	split(line, arr, "|")

	#get the weather description and
	niceness = arr[32]

	#give it a rating between 0 - 12
	rating = give_rating(niceness)

	#put the weather description as the key
	#i.e. weather[description] = weather rating
	weather[niceness] = rating
    }
    # put the weather rating and the weather description in a file
    for (i in weather)
	print weather[i]" "i> "weather_description_rating_this_one.txt"
}
# the sev code difference goes from -8 to 7
# -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 
     
      



   


      
