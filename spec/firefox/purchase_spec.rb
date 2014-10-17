require 'spec_helper'
require 'watir'
require 'date'

FROM = "RMD"
TO = "EDB"

describe "Buying a return ticket on NR" do
  before :all do
    open_browser
  end
    
  after :all do
	close_browser
  end

  it "Can search for select journeys" do
    enter_destinations FROM, TO
	@b.checkbox(:name, 'checkbox').set
	@b.text_field(:id, 'txtDate').set "01/01/2015"
	@b.select_list(:id, 'sltHours').select_value("08")
	@b.select_list(:id, 'sltMins').select_value("30")
	confirm_journey

	expect(@b.text.include? "Richmond (London) [RMD] to Edinburgh [EDB]")
  end

  it "You can buy a return ticket from these destinations" do
	@b.button(:id, 'buyCheapestButton').click
	expect(@b.url.include? "eastcoast")
  end

  it "Will throw an error when time in selected before current" do
	@b.goto "nationalrail.co.uk"
	enter_destinations FROM, TO
	today_date
	@b.text_field(:id, 'txtDate').set date
	@b.select_list(:id, 'sltHours').select_value("01")
	confirm_journey

	expect(@b.text.include? "Outward travel must not be in the past.")
  end
end