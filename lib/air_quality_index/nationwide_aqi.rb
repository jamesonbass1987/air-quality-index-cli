class AirQualityIndex::NationwideAQI

  attr_reader :todays_date, :national_aqi

  def call

    puts self.todays_rankings_output
  end

  def todays_rankings_output

    puts "Nationwide AQI Rankings for #{self.todays_date.month}/#{self.todays_date.day}/#{self.todays_date.year}"

    puts <<-DOC
    1. #{self.first_city} - #{self.first_index} (#{self.first_message})
    2. #{self.second_city} - #{self.second_index} (#{self.second_message})
    3. #{self.third_city} - #{self.third_index} (#{self.third_message})
    4. #{self.fourth_city} - #{self.fourth_index} (#{self.fourth_message})
    5. #{self.fifth_city} - #{self.fifth_index} (#{self.fifth_message})
    DOC
  end

  def todays_date
    @todays_date = Time.new
  end

  def get_nationwide_data

    #scrape page for top ranking cities
    html = AirQualityIndex::Scraper.new.nationwide_aqi_scraper

    #store first rank data
    self.first_city = "Sisters, OR"
    self.first_index = "198"
    self.first_message = "Unhealthy"

    #store second rank data
    self.second_city = "The Dalles, OR"
    self.second_index = "165"
    self.second_message = "Unhealthy"

    #store third rank data
    self.third_city = "Madras, OR"
    self.third_index = "159"
    self.third_message = "Unhealthy"

    #store fourth rank data
    self.fourth_city = "Medford, OR"
    self.fourth_index = "156"
    self.fourth_message = "Unhealthy"

    #store fifth rank data
    self.fifth_city = "Ashland, OR"
    self.fifth_index = "153"
    self.fifth_message = "Unhealthy"

  end

end
