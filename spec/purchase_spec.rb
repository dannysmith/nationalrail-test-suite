require 'spec_helper'
require 'watir'

FROM = "RMD"
TO = "SUO"

describe "Buying a return ticket on NR" do
	before(:all) do
		  open_browser
	end

	it "Can search for select journies" do
		enter_destinations FROM, TO
		confirm_journey
	end

	it "" do

	end

	after(:all) do
		#close_browser
	end
end