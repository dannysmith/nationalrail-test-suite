require 'watir'
require 'spec_helper'
require 'date'

FROM = "Richmond (London)"
TO   = "Sutton (Surrey)"
FILE = DateTime.now.strftime("%d%b%Y%H%M%S")
describe "Create and print an Itinerary on NR" do
  before(:all) do
  open_browser
  end
  # To choose any UK location
  it "Should be able to choose any UK location" do
    enter_destinations FROM, TO
    expect(@b.text.include? "Richmond (London)")
    expect(@b.text.include? "Sutton (Surrey)")
  end
  
  # To create a journey itinerary
  it "Should be able to create a journey itinerary" do
    confirm_journey
    @b.link(:id, "journeyOption0").click
    expect(@b.text.include? "Route details")
  end
  
  # To print itinerary
  it "Should be able to print itinerary" do
    @b.link(:href, "javascript:window.print()").click
    sleep(2)
    @b.screenshot.save("./screenshots/#{FILE}.png")
    @b.window(:title, "Print").use do
      b.close
    end
  end
  
  
end
