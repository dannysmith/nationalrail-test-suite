require 'rspec'
require 'watir'

RSpec.configure do|config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end

open_browser
  @b = Watir::Browser.new :firefox
  @b.goto "nationalrail.co.uk"
end

close_browser
  @b.close
end