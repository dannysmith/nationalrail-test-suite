require 'spec_helper'

describe "National Rail Journey Planner Validations" do
  before :all do
    run :firefox
    
    goto_homepage
    
    @time = Time.new
    
    @future_hour = @time.hour + 1
    @past_hour   = @time.hour - 1 # 1 hour before the current time
  end 
  
  before :each do
    @b.refresh 
  end
  
  after :all do
    close_browser
  end

  it "At least one person should be set for the journey search criteria." do
    enter_destinations RICHMOND, SUTTON
        
    set_no_of_passengers 0
    
    submit_journey_criteria
    
    expect(@b.div(id: "jp-errp").when_present.text).to include(JOURNEY_PLANNER_CRITERIA_ERROR_MESSAGE)
  end
  
  it "It should prevent a journey search if the to and from fields have the same stations." do
    enter_destinations RICHMOND, RICHMOND
    
    submit_journey_criteria
    
    expect(@b.div(id: "jp-errp").when_present.text).to include(JOURNEY_PLANNER_CRITERIA_ERROR_MESSAGE)
  end
  
  it "It should prevent a journey search if only the from field is filled in." do
    enter_destinations RICHMOND, ""
    
    submit_journey_criteria
    
    expect(@b.div(id: "jp-errp").when_present.text).to include(JOURNEY_PLANNER_CRITERIA_ERROR_MESSAGE)
  end
  
  it "It should not allow departures set in the past." do
    enter_destinations RICHMOND, SUTTON
    
    set_time_for DEPARTURE, @past_hour
    
    submit_journey_criteria
    
    expect(@b.div(id: "jp-errp").when_present.text).to include(JOURNEY_PLANNER_CRITERIA_ERROR_MESSAGE)
  end
  
  it "It should not allow returns set before the departure time." do 
    enter_destinations RICHMOND, SUTTON
    
    set_time_for DEPARTURE, @future_hour
    
    enable_return_ticket_options
    
    set_time_for RETURN, @past_hour
    
    submit_journey_criteria
    
    expect(@b.div(id: "jp-errp").when_present.text).to include(JOURNEY_PLANNER_CRITERIA_ERROR_MESSAGE)
  end    
  
  it "It should proceed with a journey search if the journey search criteria are all valid." do
    enter_destinations RICHMOND, SUTTON
    
    set_time_for DEPARTURE, @future_hour
    
    enable_return_ticket_options
    
    set_time_for RETURN, @time.hour+5 # set the return ticket for 5 hours in the future
    
    validate_return_date # fix the return date, further details available in the spec_helper
    
    set_no_of_passengers 1
    
    submit_journey_criteria
    
    expect(@b.div(id: 'ctf-results')).to exist # expect a list of journey results
  end
end