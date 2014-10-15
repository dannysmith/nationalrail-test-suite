require 'rspec'

SEARCH_BTN = "b-y lrg rgt not-IE6"

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