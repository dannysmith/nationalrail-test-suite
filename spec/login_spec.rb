require 'spec_helper'
require 'watir'
require 'pry'


describe "The National Rail website should:" do
    before :each do
        open_browser
    end
    
    #after :each do
    #   close_browser 
    #end
    
    
    #This tests the login for the National Rail website
    it "login successfully" do

        @b.element(:class, "signin").click
        @b.text_field(:id, "signinEmail").set("joebloggs@mailinator.com")
        @b.text_field(:id, "signinPword").set("abc12345")
        @b.button(:id, "loginNow").click
        fail unless @b.a(:title, "Joe Bloggs's Account").text.include? "Joe Bloggs"
    end

    #This checks that the login does not accept a non-existent user
    it "fail to login with incorrect details" do

        @b.element(:class, "signin").click
        @b.text_field(:id, "signinEmail").set("joeblo000000000000ggs@mailinator.com")
        @b.text_field(:id, "signinPword").set("abc12345wrong")
        @b.button(:id, "loginNow").click
        expect @b.a(:title, "National Rail Enquiries - Login")
    end

    #This is an automation test to see if the website logs the user out if the user is inactive for 30mins
    it "log out after 30 mins of inactivity" do

        @b.element(:class, "signin").click
        @b.text_field(:id, "signinEmail").set("joebloggs@mailinator.com")
        @b.text_field(:id, "signinPword").set("abc12345")
        @b.button(:id, "loginNow").click
        fail unless @b.a(:title, "Joe Bloggs's Account").text.include? "Joe Bloggs"
        sleep(1860)
        @b.refresh
        fail unless @b.a(:title, "Joe Bloggs's Account").text.include? "Joe Bloggs"
    end
    
    
    #This is to check if the website will lock the valid users account if the password is entered incorectly 10 times
    it "lock the user account after 10 failed logins" do
        @b.element(:class, "signin").click
        
        l = 0
        while l <= 10 do
            @b.text_field(:id, "signinEmail").set("joebloggs@mailinator.com")
            @b.text_field(:id, "signinPword").set("abc12345wrong")
            @b.button(:id, "loginNow").click
            l += 1
        end
        
        @b.text_field(:id, "signinEmail").set("joebloggs@mailinator.com")
        @b.text_field(:id, "signinPword").set("abc12345")
        @b.button(:id, "loginNow").click

        
    end
    
    
        #This tests if the user can 
    it "login successfully" do
        
        @b.goto 'https://ojp.nationalrail.co.uk/personal/login/secure?r=myAccount&'
        @b.text_field(:id, "signinEmail").set("joebloggs@mailinator.com")
        @b.text_field(:id, "signinPword").set("abc12345")
        @b.button(:id, "loginNow").click
        @b.a(:text, "Stations").click
        @b.text_field(:id, "station").set("Richmond (London)")
        @b.div.element(:id, "addStation-am").click
        @b.div.element(:id, "addStationButton").click
        expect(@b.input(:id, "station1").attribute_value("value")).to eq "Richmond (London)"

        
    end
    
end