class AirQualityIndex::NationwideAQI

  attr_accessor :todays_date, :national_aqi, :first_city, :first_index, :first_message, :second_city, :second_index, :second_message, :third_city, :third_index, :third_message, :fourth_city, :fourth_index, :fourth_message, :fifth_city, :fifth_index, :fifth_message

  def call
    self.get_nationwide_data
    puts self.todays_rankings_output
  end

  def todays_rankings_output
    puts ""
    puts "Nationwide AQI Rankings for #{self.todays_date.month}/#{self.todays_date.day}/#{self.todays_date.year}"
    puts ""
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
    self.first_city = html.search("a.NtnlSummaryCity")[0].text.strip
    self.first_index = html.search("div.TabbedPanelsContent").children.css("tr td")[1].children.text.strip
    self.first_message = aqi_message_set(self.first_index)

    #store second rank data
    self.second_city = html.search("a.NtnlSummaryCity")[1].text.strip
    self.second_index = html.search("div.TabbedPanelsContent").children.css("tr td")[6].children.text.strip
    self.second_message = aqi_message_set(self.second_index)

    #store third rank data
    self.third_city = html.search("a.NtnlSummaryCity")[2].text.strip
    self.third_index = html.search("div.TabbedPanelsContent").children.css("tr td")[11].children.text.strip
    self.third_message = aqi_message_set(self.third_index)

    #store fourth rank data
    self.fourth_city = html.search("a.NtnlSummaryCity")[3].text.strip
    self.fourth_index = html.search("div.TabbedPanelsContent").children.css("tr td")[16].children.text.strip
    self.fourth_message = aqi_message_set(self.fourth_index)

    #store fifth rank data
    self.fifth_city = html.search("a.NtnlSummaryCity")[4].text.strip
    self.fifth_index = html.search("div.TabbedPanelsContent").children.css("tr td")[21].children.text.strip
    self.fifth_message = aqi_message_set(self.fifth_index)
  end

  #set aqi messages based off of aqi index ranking
  def aqi_message_set(index)
    case index.to_i
      when 0..50
        "Good"
      when 51..100
        "Moderate"
      when 101..150
        "Unhealthy For Sensitive Groups"
      when 151..200
        "Unhealthy"
      when 201..300
        "Very Unhealthy"
      when 301 - 500
        "Hazardous"
      else
        "You are probably too dead to read this from all of the air pollution"
    end
  end
end
