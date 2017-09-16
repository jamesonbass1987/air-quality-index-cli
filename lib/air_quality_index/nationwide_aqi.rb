class AirQualityIndex::NationwideAQI

  attr_reader :todays_date

  def call
    puts "Nationwide AQI Rankings for #{self.todays_date.month}/#{self.todays_date.day}/#{self.todays_date.year}"
    puts self.todays_rankings
  end

  def todays_rankings
    puts <<-DOC
    1. Victorville, CA - 253 (Very Unhealthy)
    2. Shady Cove, OR - 177 (Unhealthy)
    3. Applegate Valley, OR - 166 (Unhealthy)
    4. Medford, OR - 164 (Unhealthy)
    5. Prineville, OR - 158 (Unhealthy)
    DOC
  end

  def todays_date
    @todays_date = Time.new
  end

end
