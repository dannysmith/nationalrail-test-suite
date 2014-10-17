require 'rspec'

SEARCH_BTN = "b-y lrg rgt not-IE6"

RSpec.configure do|config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end

def open_browser
  @b = Watir::Browser.new :chrome
  @b.goto "nationalrail.co.uk"
end

def close_browser
  @b.close
end

def enter_destinations from, to
  @b.text_field(:id, 'txtFrom').set(from)
  @b.text_field(:id, 'txtTo').set(to)
end

def confirm_journey
  @b.button(:class, SEARCH_BTN).click
end
