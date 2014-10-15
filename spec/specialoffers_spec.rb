require 'watir'
require 'spec_helper'

describe "Viewing special offers on NR" do 

	before(:all) do 
		open_browser
	end

	after(:all) do 
		close_browser
	end

	it "View special offers" do 
		@b.a(:title, "Train times & tickets").click 
		@b.a(:title, "Special offers").click 
	end 

	it "View special offers for South West Trains" do
		@b.a(:title, "South West Trains").click
		@b.td(:class, "first").click
	end
end 