require 'watir'
require 'rspec'
require 'date'
require 'time'
require 'pry'

# From and To Stations
RICHMOND = "Richmond (London)"
SUTTON   = "Sutton (Surrey)"

# The Journey Planner' GO button class name
SEARCH_BTN = 'b-y lrg rgt not-IE6' 

# User Credentials
VALID_USERNAME   = "joebloggs@mailinator.com"
INVALID_USERNAME = "INVALID_USERNAME@inv.com"
PASSWORD         = "abc12345"

DEPARTURE = "departure"
RETURN    = "return"

# Self-Explanatory ;)
JOURNEY_PLANNER_CRITERIA_ERROR_MESSAGE = "Sorry You need to correct the fields marked with errors before continuing."

# REGEX CODES
SERVICE_DISRUPTIONS = /\w+\/service_disruptions\/today.aspx/
DATE = /\w*(\d{1,2}\/\d{1,2}\/\d{4})\w*/
  
RSpec.configure do|config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end

def run browser
  @b = Watir::Browser.new browser
  @b.window.maximize
end

def close_browser
  @b.close
end

def goto_homepage 
  @b.goto "nationalrail.co.uk"
end

def click_signin_link
  @b.element(class: 'signin').click
end

def submit_credentials username, password
  @b.text_field(id: 'signinEmail').when_present.set(username)
  @b.text_field(:id, 'signinPword').set(password)
  @b.button(:id, 'loginNow').click
end

# NOTE!!! ---------------------------------------|
# I made separate methods for clicking the signin
# link and submitting the credentials because  
# sometimes, even when a user is currently logged
# in and wants to access his/her account, NR still
# presents a login page to verify the user again.
# in this case, the submit_credentials method is
# only needed because the signin link is will not
# be present in this scenario.
# -----------------------------------------------|

def signin
  click_signin_link
  submit_credentials VALID_USERNAME, PASSWORD
end

# LOGIN_SPEC ------------------------------------|

def goto_live_arrivals_and_departures
  goto_homepage
  @b.a(title: 'Train times & tickets').click
  @b.a(title: 'Live departure boards').click
end

def search_for_departures_from station
  @b.text_field(id: 'train-from').when_present.set(station)
  @b.button(id: 'planJourney').click
end

def search_for_arrivals_at station
  @b.a(class: 'ldb-r ldb-arrivals').click
  
  @b.text_field(id: 'train-from').when_present.set(station)
  @b.button(id: 'planJourney').click
end

# END OF LOGIN_SPEC -----------------------------|

def enter_destinations from, to
  @b.text_field(:id, 'txtFrom').set(from)
  @b.text_field(:id, 'txtTo').set(to)  
end

def submit_journey_criteria
  @b.button(:class, SEARCH_BTN).click
end

def set_time_for mode, hour # mode is either for the DEPARTURE or RETURN time
  hour = validate_hour(hour)
  
  if mode == DEPARTURE
    @b.select_list(id: 'sltHours').select_value(hour)
    @b.select_list(id: 'sltMins').options.first.click # always sets the minute to "00"
  else
    @b.select_list(id: 'sltHoursRet').when_present.select_value(hour)
    @b.select_list(id: 'sltMinsRet').options.first.click
  end
end

def validate_hour(hour)
  if hour > 23 # e.g. if the time is 24:00 then
    hour = hour - 24 # 24 - 24 = 0 -> 00:00 since
  end # there is no option for "24" in the dropdown hours list

  if hour < 10 # since the dropdown list for the hours list goes from 00 - 09 and onwards
    # to represent 0 - 9, if the hour set as a parameter is within this range
    hour = "0" + hour.to_s # then append a "0" before it so e.g. 9 -> "0" + 9 -> "09"
  end

  hour
end

def validate_return_date
  # if the return hour is less than the departure hour, then the return date is most probably on the
  # following day. To fix this, check if this is the case then set the return date to "Tomorrow"
  if @b.select_list(id: 'sltHoursRet').value.to_i < @b.select_list(id: 'sltHours').value.to_i
    @b.text_field(id: 'txtDateRet').set("Tomorrow")
  end
end

def enable_return_ticket_options
  @b.checkbox(id: 'ret-ch').set # enables the return ticket option
end

# GROUP TICKET SPEC ----------------------------------|

def set_no_of_passengers num_of_passengers
  @b.span(:class, 't').click # reveals the number of passengers option
  
  @b.select_list(id: 'adults').when_present.select_value(num_of_passengers.to_s)
  
  @b.span(:class, 't').click
end

def choose_first_matching_journey_result
  @b.inputs(name: 'outward.option').first.click
end

# END OF GROUP TICKET SPEC ---------------------------|

# ACCOUNT MANAGEMENT SPEC ----------------------------|

def goto_myaccount
  @b.span(text: 'Joe Bloggs').click
  @b.a(text: 'My Account').when_present.click
end

def goto_disruptions
  @b.goto "http://www.nationalrail.co.uk/service_disruptions/today.aspx"
end

# END OF ACCOUNT MANAGEMENT SPEC ---------------------|

def generate_stations_list
  @stations = []  
	
  file = File.open('.\data\uk_stations_list.txt')
  file.each do |line|
    @stations.push Regexp.new line.gsub("\n", "")
  end
end

def current_time
  @screen_name = DateTime.now.strftime("%d%b%Y%H%M%S")
end 