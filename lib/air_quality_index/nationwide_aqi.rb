class AirQualityIndex::NationwideAQI

  attr_accessor :todays_date, :national_aqi, :first_city, :first_index, :first_message, :second_city, :second_index, :second_message, :third_city, :third_index, :third_message, :fourth_city, :fourth_index, :fourth_message, :fifth_city, :fifth_index, :fifth_message, :html, :first_link, :second_link, :third_link, :fourth_link, :fifth_link

  #instantiates a new pull from AirNow.gov for the top 5 current rankings on air pollution
  def call
    self.get_nationwide_data
    puts self.todays_rankings_output
    self.get_more_info?
  end

  #outputs nationwide ranking information from scraped web data
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

  #sets today's date for data output
  def todays_date
    @todays_date = Time.new
  end

  #sets instance variables for each piece of ranking data from scraped html
  def get_nationwide_data

    #scrape page for top ranking cities
    @html = AirQualityIndex::Scraper.new.nationwide_aqi_scraper

    #store first rank data
    self.first_city = self.html.search("a.NtnlSummaryCity")[0].text.strip
    self.first_index = self.html.search("div.TabbedPanelsContent").children.css("tr td")[1].children.text.strip
    self.first_message = aqi_message_set(self.first_index)
    self.first_link = html.search("a.NtnlSummaryCity")[0]['href']

    #store second rank data
    self.second_city = self.html.search("a.NtnlSummaryCity")[1].text.strip
    self.second_index = self.html.search("div.TabbedPanelsContent").children.css("tr td")[6].children.text.strip
    self.second_message = aqi_message_set(self.second_index)
    self.second_link = html.search("a.NtnlSummaryCity")[1]['href']

    #store third rank data
    self.third_city = self.html.search("a.NtnlSummaryCity")[2].text.strip
    self.third_index = self.html.search("div.TabbedPanelsContent").children.css("tr td")[11].children.text.strip
    self.third_message = aqi_message_set(self.third_index)
    self.third_link = html.search("a.NtnlSummaryCity")[2]['href']

    #store fourth rank data
    self.fourth_city = self.html.search("a.NtnlSummaryCity")[3].text.strip
    self.fourth_index = self.html.search("div.TabbedPanelsContent").children.css("tr td")[16].children.text.strip
    self.fourth_message = aqi_message_set(self.fourth_index)
    self.fourth_link = html.search("a.NtnlSummaryCity")[3]['href']

    #store fifth rank data
    self.fifth_city = self.html.search("a.NtnlSummaryCity")[4].text.strip
    self.fifth_index = self.html.search("div.TabbedPanelsContent").children.css("tr td")[21].children.text.strip
    self.fifth_message = aqi_message_set(self.fifth_index)
    self.fifth_link = html.search("a.NtnlSummaryCity")[4]['href']

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

  #asks user if they would like additional information on any of the ranked cities, if so, pulls individual ranking information via local_aqi method call
  def get_more_info?

    puts "Would you like local information for any of the cities listed? Please enter a numerical value 1-5, type 'exit' to end program, or type any other key to return to previous menu."
    puts ""

    link = 'https://airnow.gov/'
    city_info = nil

    #gets user input
    user_input = gets.strip.downcase

    #depending on user input, sets new local aqi instance to city_info variable
    case user_input
      when '1'
        city_info = AirQualityIndex::LocalAQI.new.call_from_ranking(link.concat(self.first_link))
      when '2'
        city_info = AirQualityIndex::LocalAQI.new.call_from_ranking(link.concat(self.second_link))
      when '3'
        city_info = AirQualityIndex::LocalAQI.new.call_from_ranking(link.concat(self.third_link))
      when '4'
        city_info = AirQualityIndex::LocalAQI.new.call_from_ranking(link.concat(self.fourth_link))
      when '5'
        city_info = AirQualityIndex::LocalAQI.new.call_from_ranking(link.concat(self.fifth_link))
      when 'exit'
        exit!
      end

    #return city_info if user selected one
    city_info.local_aqi_return unless city_info.nil?

  end

end
