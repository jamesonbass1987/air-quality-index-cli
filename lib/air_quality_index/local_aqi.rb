class AirQualityIndex::LocalAQI

  attr_accessor :zip_code, :doc, :city

  #instantiates new instance based on the Local AQI option in the CLI menu
  def call_from_zip_code

    #grab user's zip code,
    self.zip_code_grabber

    #call scraper class method to access html of page based on zip code
    @doc = AirQualityIndex::Scraper.new.local_aqi_scraper(self.zip_code)

    #return aqi information, unless unavailable for that zip code
    self.aqi_info_validation_return(self.doc)
  end

  # grab zip code from user for local aqi instance
  def zip_code_grabber

    puts ''
    puts "Please enter your 5-digit zip code:"
    puts ''

    @zip_code = nil

    # checks for zip code validation utilzing is_zip_code? method
    while !self.is_zip_code?(self.zip_code)

      self.zip_code = gets.chomp

      if !self.is_zip_code?(self.zip_code)
          puts ""
          puts "I'm sorry. That entry was invalid. Please enter a valid 5 digit zip code."
          puts ""
      end

    end

    #return zip_code
    self.zip_code.to_i
  end

  #check to see if zip code is valid
  def is_zip_code?(user_zip)
    if user_zip.nil?
      false
    else
      user_zip.size == 5 && user_zip.to_i.to_s == user_zip && !user_zip.nil?
    end
  end

  #passes ranked_city instance from the Nationwide rankings based on user selection
  def call_from_ranking(ranked_city)

    site_link = 'https://airnow.gov/'

    #call scraper class method to access html of page based ranking
    @doc = AirQualityIndex::Scraper.new.nationwide_scraper_more_info(site_link.concat(ranked_city.link))

    #return aqi information for ranked city
    self.aqi_info_validation_return(self.doc, ranked_city)
  end

  #check to see if page information is available based on scraped web site data (based on zip), otherwise proceed with aqi info pull
  def aqi_info_validation_return(html, city = nil)

    page_message = html.search("h2").text.strip

    if page_message.include? "does not currently have Air Quality data"
      puts ""
      puts page_message
    else
      #store information as local instance variables
      self.local_aqi_index(city)
      #return aqi index information
      self.local_aqi_return
    end
  end

  #assign scraped information to instance variables
  def local_aqi_index(city)

    #Store 'Data Unavailable Message' as variable. Each method below checks for a nil return and sets message if found.
    unavailable_msg = "Data Not Currently Available"

    #If a ranked city instance is supplied, set @city to this instance, otherwise, create a new city instance
     if city.nil?
       @city = AirQualityIndex::City.new
     else
       @city = ranked_city
     end

    #store location information
    self.city.location_city = self.doc.search(".ActiveCity").text.strip
    self.city.location_state = self.doc.search("a.Breadcrumb")[1].text.strip

    #store aqi index
    self.doc.at('.TblInvisible').css('tr td').children[1].nil?? self.city.current_aqi_index = unavailable_msg : self.city.current_aqi_index = self.doc.at('.TblInvisible').css('tr td').children[1].text.strip
    self.doc.search("td.HealthMessage")[0].nil?? self.city.current_health_msg = unavailable_msg : self.city.current_health_msg = self.doc.search("td.HealthMessage")[0].text.strip[/(?<=Health Message: ).*/]

    #store current aqi/ozone data
    self.doc.search("table")[14].children.css("td")[4].nil?? self.city.current_pm = unavailable_msg : self.city.current_pm = self.doc.search("table")[14].children.css("td")[4].text.strip
    self.doc.search("td.AQDataPollDetails")[3].nil?? self.city.current_pm_msg = unavailable_msg : self.city.current_pm_msg = self.doc.search("td.AQDataPollDetails")[3].text.strip
    self.doc.search("table")[14].children.css("td")[1].nil?? self.city.current_ozone = unavailable_msg : self.city.current_ozone =  self.doc.search("table")[14].children.css("td")[1].text.strip
    self.doc.search("td.AQDataPollDetails")[1].nil?? self.city.current_ozone_msg = unavailable_msg : self.city.current_ozone_msg = self.doc.search("td.AQDataPollDetails")[1].text.strip

    #Extract time from site
    self.city.current_aqi_timestamp = self.timestamp

    #store todays forecast data
    self.doc.search("td.AQDataPollDetails")[7].nil?? self.city.today_aqi = unavailable_msg : self.city.today_aqi = self.doc.search("td.AQDataPollDetails")[7].text.strip
    self.doc.search("td.HealthMessage")[1].nil?? self.city.today_aqi_msg = unavailable_msg : self.city.today_aqi_msg = self.doc.search("td.HealthMessage")[1].text.strip[/(?<=Health Message: ).*/]
    self.doc.search("td.AQDataPollDetails")[5].nil?? self.city.today_ozone = unavailable_msg : self.city.today_ozone = self.doc.search("td.AQDataPollDetails")[5].text.strip

    #store tomorrows forecast data
    self.doc.search("td.AQDataPollDetails")[11].nil?? self.city.tomorrow_aqi = unavailable_msg : self.city.tomorrow_aqi = self.doc.search("td.AQDataPollDetails")[11].text.strip
    self.doc.search("td.HealthMessage")[2].nil?? self.city.tomorrow_aqi_msg = unavailable_msg : self.city.tomorrow_aqi_msg = self.doc.search("td.HealthMessage")[2].text.strip[/(?<=Health Message: ).*/]
    self.doc.search("td.AQDataPollDetails")[9].nil?? self.city.tomorrow_ozone = unavailable_msg : self.city.tomorrow_ozone = self.doc.search("td.AQDataPollDetails")[9].text.strip

    #return self
    self
  end

  #grabs timestamp of aqi measurement, if none available, sets to "Time Unavailable" and returns
  def timestamp
    timestamp = self.doc.search("td.AQDataSectionTitle").css("small").text.split(" ")
    binding.pry
    if timestamp != []
      timestamp[0].capitalize!
      timestamp = timestamp.join(" ")
    else
      timestamp = 'Time Unavailable'
    end
    timestamp
  end

  #return output message with scraped information
  def local_aqi_return

    puts <<-DOC

    Current Conditions in #{self.city.location_city}, #{self.city.location_state} (#{self.city.current_aqi_timestamp}):

    AQI: #{self.city.current_aqi_index}
    Health Message: #{self.city.current_health_msg}

    Ozone: #{self.city.current_ozone} (#{self.city.current_ozone_msg})
    Particles (PM2.5): #{self.city.current_pm} (#{self.city.current_pm_msg})

    Today's Forecast in #{self.city.location_city}, #{self.city.location_state}

    AQI: #{self.city.today_aqi}
    Ozone: #{self.city.today_ozone}
    Health Message: #{self.city.today_aqi_msg}

    Tomorrow's Forecast in #{self.city.location_city}, #{self.city.location_state}

    AQI: #{self.city.tomorrow_aqi}
    Ozone: #{self.city.tomorrow_ozone}
    Health Message: #{self.city.tomorrow_aqi_msg}

    DOC
  end

end
