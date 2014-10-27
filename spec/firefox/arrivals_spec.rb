require 'spec_helper'

describe "National Rail Live Arrivals/Departures Test" do
  before :all do
    run :firefox
  end
  
  before :each do
    goto_live_arrivals_and_departures
  end

  after :all do
    close_browser
  end
  
  it "It should show departures from the Richmond station." do
    search_for_departures_from RICHMOND
    
    expect(@b.span(class: "to").when_present.text).to include(RICHMOND)
  end
  
  it "It should show arrivals at the Richmond station." do
    search_for_arrivals_at SUTTON
    
    expect(@b.span(class: "to").when_present.text).to include(SUTTON)
  end
end