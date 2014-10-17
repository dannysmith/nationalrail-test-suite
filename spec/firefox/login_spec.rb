require 'spec_helper'
require 'watir'
require 'pry'

describe "The National Rail website should:" do
  before :each do
    open_browser
  end
    
  after :each do
    close_browser
  end

  #This tests the login for the National Rail website
  it "login successfully" do
    @b.element(:class, "signin").click
        
    enter_login_details
        
    fail unless @b.a(:title, "Joe Bloggs's Account").text.include? "Joe Bloggs"
  end

  #This checks that the login does not accept a non-existent user
  it "fail to login with incorrect details" do
    @b.element(:class, "signin").click
        
    enter_wrong_login_details
        
    expect @b.a(:title, "National Rail Enquiries - Login")
  end
    
  #This is to check if the website will lock the valid users account if the password is entered incorectly 10 times
  it "lock the user account after 10 failed logins" do
    @b.element(:class, "signin").click
        
      l = 0
      
      while l <= 10 do
        enter_wrong_login_details
        l += 1
      end
        
    enter_login_details
  end
    
    
  #This tests if the user can add stations to their account
  it "login successfully" do
    @b.goto 'https://ojp.nationalrail.co.uk/personal/login/secure?r=myAccount&'
        
    enter_login_details
        
    @b.a(:text, "Stations").click
    @b.text_field(:id, "station").set("Richmond (London)")
    @b.div.element(:id, "addStation-am").click
    @b.div.element(:id, "addStationButton").click
    expect(@b.input(:id, "station1").attribute_value("value")).to eq "Richmond (London)"
  end
    
  #This tests if the user can add stations to their account
  it "Should be able to add alerts" do   
    @b.goto 'https://ojp.nationalrail.co.uk/personal/login/secure?r=myAccount&'
        
    enter_login_details
        
    @b.a(:text, "Alerts").click
    @b.a(:class, "b-y lrg rgt alert-popup").click
        
    @b.window(:title, "National Rail Enquiries - Travel Alerts").use
        
    @b.text_field(:name, "from.searchTerm").send_keys("Richmond")
    @b.text_field(:name, "to.searchTerm").send_keys("Watford Junction")
    @b.button(:class, "b-y lrg rgt not-IE6").click
    @b.button(:id, "NextDelay").click
    @b.checkbox(:id, "chkTermsCond").click
    @b.button(:id, "submitAlert").click
    @b.button(:class, "b-y lrg rgt not-IE6").click
    
    sleep(2)
    @b.windows.last.use
        
    enter_login_details
        
    @b.a(:text, 'Alerts').click
            
    fail unless /(Richmond)\w*/.match @b.div(:class, 'b34-p clear').span(:id, 'daoFrom').text
    fail unless /(Watford Junction)\w*/.match @b.div(:class, 'b34-p clear').span(:id, 'daoTo').text
  end  
end