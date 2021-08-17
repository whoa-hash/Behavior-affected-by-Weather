# Behavior-affected-by-Weather
Using Linux to determine whether emergency calls are exaggerated by callers when weather is worse.


Summary of my Hypothesis

My hypothesis was that inclement weather causes people to exagerate when they
call the EMS. Therefore, I expected to see the more worse the weather the
greater the negative difference between the initial EMS call rating and the
final call rating.

I used two data sources: One is a historical weather data file called manhattanWeatherClean.gz. Its data is historical hourly weather data from openweathermap.org for a point in the center of Manhattan. The other is a
historical file of NYC EMS incidents called EMS_Incident_Dispatch_Data.tsv.gz.
The data therein was found at https://data.cityofnewyork.us/Public-Safety/EMS-Incident-Dispatch-Data/76xm-jjuj

The way in which I computed the results was thus: First, I put together the
EMS call dates and the corresponding severity code differences (I didn't use
differences of 0 because I didn't want the zeros pulling the average later on.).
Second, I put together the weather description names for the EMS call dates and put them together with the severity code differences from the EMS file. Third, I gave corresponding ratings to each weather description. Fourth, I used the EMS call dates file and the weather file to give the EMS call dates the correspondingweather rating. After, I condensed the weather rating with the corresponding severity codes into an average severity code difference per rating. Then, I graphed a scatter plot based on those averages as the y values and the weather ratings as the x values.

My conclusion is that in general, inclement weather has very little effect on the behavior of the caller to exaggerate, since the graph shows little correlation between weather condition rating and exaggeration. However, the weather condition of 12 which is squalls (A squall is often named for the weather phenomenon that accompanies it, such as rain, hail, or thunder - Britannica.com)seems to have the expected very high correlation, so maybe exaggeration occurs more with that type of inclement weather.

![image](https://user-images.githubusercontent.com/59946519/129798399-c25075d2-7092-4973-bf74-591255be0d2c.png)

