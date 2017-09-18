# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'air_quality_index/version'

Gem::Specification.new do |spec|
  spec.name          = "air_quality_index"
  spec.version       = AirQualityIndex::VERSION
  spec.authors       = ["'Jameson Bass'"]
  spec.email         = ["'jamesonbass@gmail.com'"]

  spec.summary       = %q{Air quality index grabber}
  spec.description   = %q{This gem pulls local Air Quality Index measurements and forecasts based on Zip Code. Users can also view the top 5 national rankings for AQI Indexes (most polluted areas)}
  spec.homepage      = "https://github.com/jamesonbass1987/air_quality_index"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
