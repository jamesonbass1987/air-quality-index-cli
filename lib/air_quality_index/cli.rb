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
      user_input = gets.strip.downcase
      #based on user input, call appropriate class method
      case user_input
      when '1'
        AirQualityIndex::LocalAQI.new.call
        self.return_message
      when '2'
        AirQualityIndex::NationwideAQI.new.call
        self.return_message
      when '3'
        AirQualityIndex::AQI_Information.new.call
        self.return_message
      when 'return'
        self.list_options
        self.menu
      else
        puts "Invalid entry. Please enter a numeric selection 1-3, or type 'exit'."
      end
    end
  end

  def return_message
    puts ""
    puts "Type 'return' to go back to previous menu, or type 'exit'."
    puts ""
  end

end
