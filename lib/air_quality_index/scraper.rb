class AirQualityIndex::Scraper

  #scrape AQI webpage based on submitted zip code

  def local_aqi_scraper(zip_code)
  @doc = Nokogiri::HTML(open("https://airnow.gov/index.cfm?action=airnow.local_city&zipcode=#{zip_code}"))
  end


end
