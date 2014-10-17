require 'rspec'
require 'time'

SEARCH_BTN = "b-y lrg rgt not-IE6" # The Journey Planner' GO button class name
FROM = "Richmond"
TO   = "Watford Junction"

# REGEX CODES
SERVICE_DISRUPTIONS = /\w+\/service_disruptions\/today.aspx/
DATE = /(\d{1,2}\/\d{1,2}\/\d{4})/
# END OF REGEX CODES
  
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

def return_homepage
  @b.goto "nationalrail.co.uk"
end

def enter_destinations from, to
  @b.text_field(:id, 'txtFrom').set(from)
  @b.text_field(:id, 'txtTo').set(to)
end

def confirm_journey
  @b.button(:class, SEARCH_BTN).click
end

def set_no_of_passengers num_of_passengers
  @b.span(:class, 't').click # reveals the number of passengers option
    
  @b.select_list(:id, 'adults').wait_until_present
  
  @b.select_list(:id, 'adults').select_value(num_of_passengers.to_s)
end

def click_first_matching_journey_result
  @b.label(:class, 'opsingle').input(:value, '4-2-1-s').click
end

def enter_login_details
  @b.text_field(:id, "signinEmail").set("joebloggs@mailinator.com")
  @b.text_field(:id, "signinPword").set("abc12345")
  @b.button(:id, "loginNow").click
end

def enter_wrong_login_details
  @b.text_field(:id, "signinEmail").set("joebloggs@mailinator.com")
  @b.text_field(:id, "signinPword").set("abc1234WRONG5")
  @b.button(:id, "loginNow").click
end

def logout
  @b.span(:text, 'Joe Bloggs').click
  sleep(1)
  @b.a(:text, 'Sign out').click
end

def generate_stations_list
  @stations = []  
	
	file = File.open('.\data\uk_stations_list.txt')
	file.each do |line|
		@stations.push Regexp.new line.gsub("\n", "")
    end
end