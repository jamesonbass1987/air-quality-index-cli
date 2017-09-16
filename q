
[1mFrom:[0m /home/jamesonbass-88057/code/final_projects/air_quality_index/lib/air_quality_index/local_aqi.rb @ line 49 AirQualityIndex::LocalAQI#local_aqi_index:

    [1;34m47[0m: [32mdef[0m [1;34mlocal_aqi_index[0m
    [1;34m48[0m: 
 => [1;34m49[0m:   binding.pry
    [1;34m50[0m: 
    [1;34m51[0m:   [1;34m#store location information[0m
    [1;34m52[0m:   [1;36mself[0m.current_location_city = @doc.search([31m[1;31m"[0m[31m.ActiveCity[1;31m"[0m[31m[0m).text.strip
    [1;34m53[0m:   [1;36mself[0m.current_location_state = [31m[1;31m'[0m[31mOregon[1;31m'[0m[31m[0m
    [1;34m54[0m: 
    [1;34m55[0m:   [1;34m#store current aqi/ozone data[0m
    [1;34m56[0m:   [1;36mself[0m.current_aqi = [31m[1;31m'[0m[31m135[1;31m'[0m[31m[0m
    [1;34m57[0m:   [1;36mself[0m.current_aqi_msg = [31m[1;31m'[0m[31m(Unhealthy For Sensitive Groups)[1;31m'[0m[31m[0m
    [1;34m58[0m:   [1;36mself[0m.current_ozone = [31m[1;31m'[0m[31m13[1;31m'[0m[31m[0m
    [1;34m59[0m:   [1;36mself[0m.current_ozone_msg = [31m[1;31m'[0m[31m(Good)[1;31m'[0m[31m[0m
    [1;34m60[0m:   [1;36mself[0m.current_aqi_timestamp = [31m[1;31m'[0m[31m10:00 PDT[1;31m'[0m[31m[0m
    [1;34m61[0m: 
    [1;34m62[0m:   [1;34m#store todays forecast data[0m
    [1;34m63[0m:   [1;36mself[0m.today_aqi = [31m[1;31m'[0m[31mGood[1;31m'[0m[31m[0m
    [1;34m64[0m:   [1;36mself[0m.today_aqi_msg = [31m[1;31m'[0m[31mNone[1;31m'[0m[31m[0m
    [1;34m65[0m:   [1;36mself[0m.today_ozone = [31m[1;31m'[0m[31mGood[1;31m'[0m[31m[0m
    [1;34m66[0m: 
    [1;34m67[0m:   [1;34m#store tomorrows forecast data[0m
    [1;34m68[0m: 
    [1;34m69[0m:   [1;36mself[0m.tomorrow_aqi = [31m[1;31m'[0m[31mGood[1;31m'[0m[31m[0m
    [1;34m70[0m:   [1;36mself[0m.tomorrow_aqi_msg = [31m[1;31m'[0m[31mNone[1;31m'[0m[31m[0m
    [1;34m71[0m:   [1;36mself[0m.tomorrow_ozone = [31m[1;31m'[0m[31mGood[1;31m'[0m[31m[0m
    [1;34m72[0m: 
    [1;34m73[0m:   [1;34m#return self[0m
    [1;34m74[0m:   [1;36mself[0m
    [1;34m75[0m: [32mend[0m

