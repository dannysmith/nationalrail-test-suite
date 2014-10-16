require 'spec_helper'
require 'watir'

FROM = "RMD"
TO = "SUO"

describe "Buying a return ticket on NR" do
	before(:all) do
		  open_browser
	end

	it "Can search for select journeys" do
		enter_destinations FROM, TO
		@b.checkbox(:name, "checkbox").set

		confirm_journey

		expect(@b.text.include? "Richmond (London) [RMD] to Sutton (Surrey) [SUO]")
	end

	it "You can buy a return ticket from these destinations" do
		@b.button(:id, "buyCheapestButton").click
		expect(@b.url.include? "northernrail")
	end

	after(:all) do
		close_browser
	end
end