require 'spec_helper'

describe "Create and print an Itinerary on NR" do
  before :all do
    run :chrome
    goto_homepage
  end
  
  after :all do
    close_browser
  end

  # To choose any UK location
  it "Should be able to choose any UK location" do
    sleep 2
    enter_destinations RICHMOND, SUTTON
    expect(@b.text.include? RICHMOND)
    expect(@b.text.include? SUTTON)
  end
  
  # To create a journey itinerary
  it "Should be able to create a journey itinerary" do
    submit_journey_criteria
    sleep 2
    @b.element(:id, "journeyOption0").click
    expect(@b.text.include? "Route details")
  end
  
  # To print itinerary
  it "Should be able to print itinerary" do
    sleep 1
    @b.element(:text, "Print").click
    @b.windows.last.use
    @b.screenshot.save("./screenshots/#{current_time}.png")
    expect(@b.text.include? "Print")
   end
end