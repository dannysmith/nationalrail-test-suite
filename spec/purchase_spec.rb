require 'spec_helper'
require 'watir'

describe "Buying a return ticket on NR" do
	before(:all) do
		  open_browser
	end

	it "Can search for select journies" do
		@b.text_field(:id, "txtFrom").set "Richmond"
		@b.text_field(:id, "txtTo").set "Sutton"	

	end


	after(:all) do
		close_browser
	end
end