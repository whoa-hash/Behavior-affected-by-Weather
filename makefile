all: graph_inclementWeather_EMScalls.pdf	#we want a pdf at the end

clean:
	rm average_for_plot_data.txt final_weatherRate_AND_severity.txt weather_description_rating_this_one.txt weather_descriptionANDsev_diff.txt EMS_matches_weathr_dateAND_sev_code_diff.txt graph_inclementWeather_EMScalls.pdf

#./scatter_plot draws the plot (which will be converted to a pdf)

graph_inclementWeather_EMScalls.pdf: average_for_plot_data.txt scatter_plot.py
	./scatter_plot.py

average_for_plot_data.txt: final_weatherRate_AND_severity.txt real_final_weathercondition_AVG-EMSdiff.py
	./real_final_weathercondition_AVG-EMSdiff.py

final_weatherRate_AND_severity.txt: weather_description_rating_this_one.txt weather_descriptionANDsev_diff.txt diff_final.awk
	./diff_final.awk

weather_description_rating_this_one.txt: this_one_array_for_weather_ratings.awk
	./this_one_array_for_weather_ratings.awk

weather_descriptionANDsev_diff.txt: EMS_matches_weather_dateAND_sev_code_diff.txt niceness_date_with_function.awk
	./niceness_date_with_function.awk

EMS_matches_weather_dateAND_sev_code_diff.txt: 
	./weatherRatings_and_dates.awk



