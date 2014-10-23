require 'spec_helper'
require 'watir'

FROM = "Richmond (London)"
TO   = "Clapham Junction"
NUM_OF_PASSENGERS = 6

describe "Booking a group ticket" do
  before :all do
    open_browser
  end
  
  after :each do
    return_homepage
  end
    
  after :all do
    close_browser
  end
  
  it "Should prevent a journey if it has the same from and to destinations" do
    enter_destinations FROM, FROM
    
    set_no_of_passengers 6
    
    confirm_journey
    
    expect(@b.url).to eq("http://ojp.nationalrail.co.uk/service/planjourney/search")
  end
  
  it "Should prevent a journey if mandatory fields are not filled in" do
    enter_destinations "", FROM
    
    confirm_journey
    
    expect(@b.url).to eq("http://ojp.nationalrail.co.uk/service/planjourney/search")
  end
  
  it "Should allow 2 or more people to book a single journey" do
    @b.goto "nationalrail.co.uk"
    
    enter_destinations FROM, TO
    
    set_no_of_passengers 6
    
    confirm_journey
    
    click_first_matching_journey_result
    
    # IN JOURNEY SUMMARY PAGE !!! ------------------------------------------------|
    fail unless @b.div(:class, 'sp-t').when_present.text.include? "#{NUM_OF_PASSENGERS} x Adult"
    # expects 6 x Adult
  end
end