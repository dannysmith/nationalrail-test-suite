require 'watir'
require 'spec_helper'

FROM = "Richmond (London)"
TO   = "Clapham Junction"
NUM_OF_PASSENGERS = 6

describe "Booking a group ticket" do
  before :each do
    open_browser
  end
  
  after :each do
    close_browser
  end
  
  it "Should prevent a journey if it has the same from and to destinations" do
    enter_destinations FROM, FROM
    
    set_no_of_passengers 6
    
    confirm_journey
    
    expect(@b.url).to eq("http://ojp.nationalrail.co.uk/service/planjourney/search")
  end
  
  it "Should allow 2 or more people to book a single journey" do
    enter_destinations FROM, TO
    
    set_no_of_passengers 6
    
    confirm_journey
    
    click_first_matching_journey_result
    
    @b.div(:class, 'b-i').wait_until_present
    fail unless @b.div(:class, 'b-i').text.include? FROM # expects Richmond 
    fail unless @b.div(:class, 'b-i').text.include? TO   # expects Clapham Junction
    
    @b.div(:class, 'sp-t').wait_until_present        # expects 6 x Adult
    fail unless @b.div(:class, 'sp-t').text.include? "#{NUM_OF_PASSENGERS} x Adult"
  end
  
  
end