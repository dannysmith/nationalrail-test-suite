require 'spec_helper'

describe "National Rail Login Validations" do
  before :all do
    run :firefox
  end
  
  before :each do
    goto_homepage
  end

  after :all do
    close_browser
  end
  
  it "It should prevent a user from logging invalid credentials are entered." do
    click_signin_link
    
    submit_credentials INVALID_USERNAME, PASSWORD
    
    expect(@b.p(class: "error-message").text).to include("This email address or password has not been recognised. Please re-enter.")
  end
  
  it "It should allow a user to login using valid credentials." do
    click_signin_link
    
    submit_credentials VALID_USERNAME, PASSWORD
    
    expect(@b.div(class: "page home logged-in")).to exist
  end
end