require 'rspec'
require 'watir'

RSpec.configure do|config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end

def open_browser
  @b = Watir::Browser.new :firefox
  @b.goto "nationalrail.co.uk"
end

def close_browser
  @b.close
end