class AirQualityIndex::CLI

  def call

    puts "Welcome to Air Quality Index (AQI) Grabber"
    self.list_options
    self.menu

  end

  def list_options
    puts <<-DOC.gsub /^\s*/, ''
    1. Local AQI Information
    2. Top 5 Nationwide AQI Rankings
    3. General AQI Information
    DOC
  end

  def menu

    puts "Please enter 1-3 to make your selection, or type exit."

    user_input = nil

    while user_input != 'exit'
      #gets user input
      user_input = gets.chomp

      #based on user input, call appropriate class method

      if user_input == '1'
        #AirQualityIndex::LocalAQI
        puts "Please enter your zip code:"
      elsif user_input == '2'
        #AirQualityIndex::NationwideAQI
        puts "Nationwide AQI Rankings"
        puts <<-DOC
        1. Victorville, CA - 253 (Very Unhealthy)
        2. Shady Cove, OR - 177 (Unhealthy)
        3. Applegate Valley, OR - 166 (Unhealthy)
        4. Medford, OR - 164 (Unhealthy)
        5. Prineville, OR - 158 (Unhealthy)
        DOC
      elsif user_input == '3'
        #AirQualityIndex::AQI_Information
        puts 'Each category corresponds to a different level of health concern. The six levels of health concern and what they mean are:'
        puts ""
        puts '"Good" AQI is 0 to 50. Air quality is considered satisfactory, and air pollution poses little or no risk.'
        puts ""
        puts '"Moderate" AQI is 51 to 100. Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people. For example, people who are unusually sensitive to ozone may experience respiratory symptoms.'
        puts ""
        puts '"Unhealthy for Sensitive Groups" AQI is 101 to 150. Although general public is not likely to be affected at this AQI range, people with lung disease, older adults and children are at a greater risk from exposure to ozone, whereas persons with heart and lung disease, older adults and children are at greater risk from the presence of particles in the air.'
        puts ""
        puts '"Unhealthy" AQI is 151 to 200. Everyone may begin to experience some adverse health effects, and members of the sensitive groups may experience more serious effects.'
        puts ""
        puts '"Very Unhealthy" AQI is 201 to 300. This would trigger a health alert signifying that everyone may experience more serious health effects.'
        puts ""
        puts '"Hazardous" AQI greater than 300. This would trigger a health warnings of emergency conditions. The entire population is more likely to be affected.'

      else
        "Invalid entry. Please enter a numeric selection 1-3, or type 'exit'."
      end
    end
  end
end
