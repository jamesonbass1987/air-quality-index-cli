class AirQualityIndex::LocalAQI

  attr_accessor :zip_code, :todays_index, :current_location, :current_aqi, :current_ozone, :current_aqi_msg, :current_ozone_msg, :current_aqi_timestamp, :today_aqi, :today_aqi_msg, :tomorrow_aqi, :tomorrow_aqi_msg, :today_ozone, :tomorrow_ozone

  def call
    self.zip_code_grabber
    self.aqi_scraper(self.zip_code)
    self.local_aqi_return(self.local_aqi_index)
  end

  # grab zip code from user
  def zip_code_grabber

    puts "Please enter your 5-digit zip code:"
    @zip_code = nil

    while !self.is_zip_code?(self.zip_code)
      self.zip_code = gets.chomp
    end

    #return zip_code
    self.zip_code.to_i
  end

  #check to see if zip code is valid

  def is_zip_code?(user_zip)
    if user_zip == nil
      false
    else
      user_zip.size == 5 && user_zip.to_i.to_s == user_zip && user_zip != nil
    end
  end

  #scrape AQI webpage based on submitted zip code

  def aqi_scraper(zip_code)

  @doc = Nokogiri::HTML(open("https://airnow.gov/index.cfm?action=airnow.local_city&zipcode=#{zip_code}"))

  end

  def

  #assign scraped information

  def local_aqi_index

    #store location information
    self.current_location = 'Portland'

    #store current aqi/ozone data

    self.current_aqi = '135'
    self.current_aqi_msg = '(Unhealthy For Sensitive Groups)'
    self.current_ozone = '13'
    self.current_ozone_msg = '(Good)'
    self.current_aqi_timestamp = '10:00 PDT'

    #store todays forecast data
    self.today_aqi = 'Good'
    self.today_aqi_msg = 'None'
    self.today_ozone = 'Good'

    #store tomorrows forecast data

    self.tomorrow_aqi = 'Good'
    self.tomorrow_aqi_msg = 'None'
    self.tomorrow_ozone = 'Good'

    #return self
    self
  end

  #return output message with scraped information

  def local_aqi_return(local_aqi)

    puts <<-DOC

    Current Conditions in #{local_aqi.current_location} (AQI Observed at #{local_aqi.current_aqi_timestamp}):

    AQI - #{local_aqi.current_aqi} #{local_aqi.current_aqi_msg}
    Ozone - #{local_aqi.current_ozone} #{local_aqi.current_ozone_msg}

    Today's Forecast in #{local_aqi.current_location}

    AQI - #{local_aqi.today_aqi}
    Ozone - #{local_aqi.today_ozone}
    Health Message - #{local_aqi.today_aqi_msg}


    Tomorrow's Forecast in #{local_aqi.current_location}

    AQI - #{local_aqi.tomorrow_aqi}
    Ozone - #{local_aqi.tomorrow_ozone}
    Health Message - #{local_aqi.tomorrow_aqi_msg}
    DOC

  end
end
