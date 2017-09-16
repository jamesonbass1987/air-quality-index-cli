class AirQualityIndex::LocalAQI

  attr_accessor :zip_code

  def call
    self.zip_code_grabber
  end

  # grab zip code from user
  def zip_code_grabber

    puts "Please enter your 5-digit zip code:"
    @zip_code = nil

    while !self.is_zip_code?(self.zip_code)
      self.zip_code = gets.chomp
    end

    #return zip_code
    self.zip_code.to_i
  end

  #check to see if zip code is valid

  def is_zip_code?(user_zip)
    if user_zip == nil
      false
    else
      user_zip.size == 5 && user_zip.to_i.to_s == user_zip && user_zip != nil
    end
  end
end
