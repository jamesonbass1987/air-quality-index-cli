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
        AirQualityIndex::NationwideAQI.new.call
      elsif user_input == '3'
        AirQualityIndex::AQI_Information.new.call
      else
        "Invalid entry. Please enter a numeric selection 1-3, or type 'exit'."
      end
    end
  end
end
