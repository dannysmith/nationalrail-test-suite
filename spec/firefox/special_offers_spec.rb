require 'spec_helper'

describe "National Rail Special Offers" do
  before :all do
    run :firefox
    
    goto_homepage
    @b.a(text: 'Train times & tickets').click 
    @b.a(text: 'Special offers').click 
  end
  
  after :all do
    close_browser
  end
  
  it "It should have a Special Offers section present." do
    expect(@b.text).to include("Special offers by train company")
  end
  
  it "View special offers for South West Trains and check offer is in date." do
    @b.a(text: 'South West Trains').click
    
    @b.tr(text: 'Chessington World of Adventure').click
    
    @b.a(text: 'Read more about Chessington World of Adventure').when_present.click
    
    @b.div(text: 'Validity').click # click on the offer's validity
    
    @b.dl(class: 'zebra', index: 2).dt(index: 4).wait_until_present
    
    expect(@b.text).to include("Now - Until further notice")
  end
  
  it "Validate a special offer's end date from Virgin Trains" do
    @b.a(text: 'By Train Company').click
    
    @b.a(text: 'Virgin Trains').click
    
    @b.tr(text: 'Chester Zoo and Bus').click
    
    @b.a(text: 'Read more about Chester Zoo and Bus').when_present.click
    
    @b.div(text: 'Validity').click
    
    @b.dl(class: 'zebra', index: 2).dt(index: 4).wait_until_present
    
    sections = @b.divs(class: 'acc-c route clear')
    dates = sections[2].dd(index: 5).text # extract the start and due date for this offer
    
    valid_until = /\s(\d{1,2}\/\d{1,2}\/\d{4})/.match(dates)
    valid_until = valid_until[1]
    date_today = Time.now.strftime("%d/%m/%Y").to_s

    fail unless Date.parse(valid_until) - Date.parse(date_today) > 0
  end
end