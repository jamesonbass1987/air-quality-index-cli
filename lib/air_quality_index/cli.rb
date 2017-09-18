class AirQualityIndex::CLI

  #instantiates a new CLI instance for the program
  def call

    puts ''
    puts "Welcome to Air Quality Index (AQI) Grabber"
    puts ''

    self.list_options
    self.menu

  end

  #lists menu options for user to select from
  def list_options
    puts <<-DOC.gsub /^\s*/, ''

    1. Local AQI Information
    2. Top 5 Nationwide AQI Rankings
    3. General AQI Information

    DOC
  end

  #grabs user selection from menu and instantiates appropriate method based on that selection
  def menu

    puts ''
    puts "Please enter a numeric selection (1-3), or type exit."
    puts ''

    user_input = nil

    while user_input != 'exit'

      #gets user input
      user_input = gets.strip.downcase
      #based on user input, call appropriate class method
      case user_input
      when '1'
        AirQualityIndex::LocalAQI.new.call_from_zip_code
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
      when 'exit'
        exit!
      else
        puts "I'm sorry. I didn't understand what you meant. Please enter a numeric selection (1-3), or type exit."
      end
    end
  end

  #return message displayed after each menu selection call
  def return_message
    puts "Type 'return' to go back to previous menu, or type 'exit'."
    puts ""
  end

end
