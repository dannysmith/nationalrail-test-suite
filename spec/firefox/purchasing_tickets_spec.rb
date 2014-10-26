require 'spec_helper'

describe "National Rail Ticket Purchasing" do
  before :all do
    run :firefox
    
    @time = Time.new
    
    @future_hour = @time.hour + 1 # just to make sure that the departure
  end
  
  before :each do
    goto_homepage
  end
  
  after :all do
    close_browser
  end
  
  it "It should be possible to book a journey for 8 people." do
    enter_destinations RICHMOND, SUTTON

    set_time_for DEPARTURE, @future_hour
    
    set_no_of_passengers 8
        
    submit_journey_criteria
    
    choose_first_matching_journey_result
    
    sleep(1) # a sleep is needed here to help watir
    @b.window.use # focus on my main window
    
    fail unless @b.div(:class, 'sp-t').when_present.text.include? "8 x Adult"
  end
  
  it "It should be possible to buy a return ticket." do
    enter_destinations RICHMOND, SUTTON
    
    set_time_for DEPARTURE, @future_hour
    
    enable_return_ticket_options
    
    set_time_for RETURN, @future_hour+5 # set the return ticket for 5 hours in the future
    
    validate_return_date # fix the return date, further details available in the spec_helper
    
    submit_journey_criteria
    
    @b.inputs(name: 'outward.option').first.click   # choose the first outward option
    @b.inputs(name: 'returning.option').first.click # choose the first return option
    
    @b.button(id: 'buyButton').when_present.click
  
    sleep(1) # a sleep is needed here to help watir
    @b.window.use # focus on my main window
    
    # OUTWARD TABLE
    expect(@b.div(class: 'b-i', index: 0).dl.dd(index: 0).text).to include(RICHMOND) # FROM
    expect(@b.div(class: 'b-i', index: 0).dl.dd(index: 1).text).to include(SUTTON)   # TO
    
    # Both of these tables have class names 'b-i' for some strange reason
    
    # RETURNING TABLE
    expect(@b.div(class: 'b-i', index: 1).dl.dd(index: 0).text).to include(SUTTON) # FROM
    expect(@b.div(class: 'b-i', index: 1).dl.dd(index: 1).text).to include(RICHMOND)   # TO
    
    expect(@b.a(title: /\w*Return\w*/)).to exist # expect the "Return Ticket" text to exist on the journey summary page
  end
end