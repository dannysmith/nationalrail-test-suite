require 'watir'
require 'spec_helperchrome'
require 'date'

FROM = "Richmond (London)"
TO   = "Sutton (Surrey)"
FILE = DateTime.now.strftime("%d%b%Y%H%M%S")
describe "Create and print an Itinerary on NR" do
  before :all do
    open_browser
  end

  # To choose any UK location
  it "Should be able to choose any UK location" do
    sleep 2
    enter_destinations FROM, TO
    expect(@b.text.include? "Richmond (London)")
    expect(@b.text.include? "Sutton (Surrey)")
  end
  
  # To create a journey itinerary
  it "Should be able to create a journey itinerary" do
    confirm_journey
    sleep 2
    @b.element(:id, "journeyOption0").click
    expect(@b.text.include? "Route details")
  end
  
  # To print itinerary
  it "Should be able to print itinerary" do
    sleep 1
    @b.element(:text, "Print").click
    @b.windows.last.use
    @b.screenshot.save("./screenshots/#{FILE}.png")
    expect(@b.text.include? "Print")
   end
  
  
end
