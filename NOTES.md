Air Quality Index Notes

How to build a CLI Gem

1. Plan your gem, imagine your interface
2. Start with the project structure - google
3. Start with the entry point - the file run
4. Force that to build the CLI Interface
5. Stub out the interface
6. Stat making things real
7. Discover objects
8. Program

- Build a command line interface to pull Air Quality Index for inputted zip code

user types air_quality_index

CLI welcomes user.

Asks for user if they would like to get local AQI index information, nationwide AQI information (highest AQI areas in the United States) or enter "More Information" to get overview about air quality indexes

Desired Output -

- If user types in nationwide AQI information, application retrieves top 5 AQI indexed areas from https://airnow.gov/index.cfm?action=airnow.main

1. Victorville, CA - 253 (Very Unhealthy)
2. Shady Cove, OR - 177 (Unhealthy)
3. Applegate Valley, OR - 166 (Unhealthy)
4. Medford, OR - 164 (Unhealthy)
5. Prineville, OR - 158 (Unhealthy)

-  If user enters local index, CLI asks user to enter a desired zip code (ie. 97211 (Portland, OR))

Current Conditions in Portland (AQI Observed at 10:00 PDT):

AQI - 135 (Unhealthy for Sensitive Groups)
Ozone - 13 (Good)
Particles (PM2.5) - 136 (Unhealthy for Sensitive Groups)

Today's Forecast in Portland

AQI - Good
Health Message - None

Tomorrow's Forecast in Portland

AQI - Good
Health Message - None

- More information puts information from AQI Index Basics Page (https://airnow.gov/index.cfm?action=aqibasics.aqi#good)
