require 'spec_helper'

describe "The Perks of Being a Registered National Rail Enquiries User" do
  before :all do
    run :firefox
    
    goto_homepage
    
    signin
  end
  
  before :each do
    goto_myaccount
  end
  
  after :all do
    close_browser
  end
  
  it "A registered user should be able to add a home station to his account" do
    # there is a problem with how watir handles a user login session and
    # so in order for this test to pass, National Rail requires
    # user authentication even when a user is already logged in
    submit_credentials VALID_USERNAME, PASSWORD 
    
    @b.a(text: 'Stations').when_present.click # access the user account's saved stations list
    
    @b.text_field(id: 'station').when_present.set(SUTTON) # set the station name to "Sutton (Surrey)"
    
    @b.input(name: 'workHome', value: '1').click # set this station as the "Work" station; value: '2' is for the "Home" station
    
    @b.input(id: 'addStationButton').click # # add this station to the account's station list
    
    stations_list = @b.text_fields(id: /station\w*/)
    
    # expect the most recently added station to the list is SUTTON
    expect(stations_list[stations_list.length-2].when_present.value).to include(SUTTON)
  end
  
  it "A registered user should be able to add alerts to his account" do
    @b.a(text: 'Alerts').when_present.click
    
    @b.a(text: 'Set up a new alert').when_present.click
    
    @b.window(:title, "National Rail Enquiries - Travel Alerts").when_present.use
    
    @b.text_field(id: 'txtFrom').set(RICHMOND)
    @b.text_field(id: 'txtTo').set(SUTTON)
    
    @b.button(text: 'Next').click # both Next buttons on the next two..
    
    @b.button(text: 'Next').click # ..pages have the same button names
    
    @b.checkbox(id: "chkTermsCond").when_present.click
    
    @b.button(text: 'Confirm alerts').click
    
    @b.button(text: 'Close this window').click
    
    sleep(1)
    @b.windows.last.use # focus back to the Travel Alerts window
    
    expected_station = @b.tr(:class, "first")
    
    expect(expected_station[1].text).to include(RICHMOND)
    expect(expected_station[2].text).to include(SUTTON)
  end
end