require 'spec_helper'
require 'watir'
require 'date'

# Tests used to verify a user being able to view special offers from different train operatorssss
describe "Viewing special offers on NR" do 
  before :all do 
    open_browser
  end

  after :all do 
    close_browser
  end

  it "View special offers" do 
    @b.a(:title, 'Train times & tickets').click 
	@b.a(:title, 'Special offers').click 

	expect @b.text.include? "Special offers by train company"
  end 

  it "View special offers for South West Trains and check offer is in date" do
	@b.a(:title, 'South West Trains').click
	@b.td(:class, 'first').click
	@b.a(:href, "http://www.nationalrail.co.uk/times_fares/prd359000a04000200b5da61f1e92b72.aspx").click 
	@b.div(:id, 'num3').click

	expect @b.text.include?("Applies - Until further notice")
  end

  it "View special offers and check validity against today's date" do 
    @b.a(:href, "/times_fares/359.aspx").click
	@b.a(:title, "Virgin Trains").click

	sections = @b.trs(:class, 'accordian-header')
	sections[8].click
	sleep(1)
	@b.a(:text, "Read more about Chester Zoo and Bus").click
	@b.div(:id, 'num3').click
	sections = @b.divs(:class, 'acc-c route clear')
	dates = sections[2].dd(:index => 5).text
	valid_until = /\s(\d{1,2}\/\d{1,2}\/\d{4})/.match(dates)
	valid_until = valid_until[1]
	date_today = Time.now.strftime("%d/%m/%Y").to_s

	fail unless Date.parse(valid_until) - Date.parse(date_today)
  end 
end


