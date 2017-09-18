require 'nokogiri'
require 'open-uri'
require 'pry'


require_relative "./air_quality_index/version"
require_relative "./air_quality_index/cli"
require_relative "./air_quality_index/local_aqi"
require_relative "./air_quality_index/nationwide_aqi"
require_relative "./air_quality_index/aqi_info"
require_relative "./air_quality_index/scraper.rb"

module AirQualityIndex
end
