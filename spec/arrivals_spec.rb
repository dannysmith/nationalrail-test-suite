require 'spec_helper'
require 'watir'

describe "Live Arrival/Departures Tests" do
    before :each do
        open_browser
    end
    
    after :each do
        close_browser
    end
    
    it "should allow you to search for any valid uk station" do
        place = "Richmond (London)"
        @b.a(:title, "Train times & tickets").click
        @b.a(:title, "Live departure boards").click
        @b.text_field(:id, "train-from").click
        @b.text_field(:id, "train-from").clear
        @b.text_field(:id, "train-from").send_keys(place)
        @b.button(:id, "planJourney").click
        @b.h1(:class, "sifr").wait_until_present
        
#        puts "SUCCESS" if @b.h1(:class, "sifr").text.include? "yufiuffuifif"
        
        
        fail unless @b.h1(:class, "sifr").text.include? "Live departures & arrivals"
        
        expect(@b.h1.text.include?("Live departures & arrivals")).to eq(true)
        
        expect(@b.h2.text.include?(place)).to eq(true)
        
#        puts "Richmond departures page shown!" if @b.span(:class, "to").text.include?(place)
        
        
    end
end
