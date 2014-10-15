require 'watir-webdriver'
require 'spec_helper'


describe "Create and print an Itinerary on NR" do
  open_browser
  
  # To choose any UK location
  it "Should be able to choose any UK location" do
    @b.text_field(:id, "txtFrom").set "Richmond"
  end
  
  # To create a journey itinerary
  it "Should be able to create a journey itinerary" do
    
  end
  
  # To print itinerary
  it "Should be able to print itinerary" do
    
  end
  
  
end
