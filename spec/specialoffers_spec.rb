require 'spec_helper'
require 'watir'

# Tests used to verify a user being able to view 
describe "Viewing special offers on NR" do 
	before :all do 
		open_browser
	end

	after :all do 
		close_browser
	end

	it "View special offers" do 
		@b.a(:title, "Train times & tickets").click 
		@b.a(:title, "Special offers").click 
		expect(@b.text.include? "Special offers by train company")
	end 

	it "View special offers for South West Trains" do
		@b.a(:title, "South West Trains").click
		@b.td(:class, "first").click
		expect(@b.text.include? "16-25 Railcard")
	end
end 