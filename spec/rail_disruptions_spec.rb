require 'watir'
require 'spec_helper'
require 'date'

describe "Checking rail disruptions" do
  before :all do
    @current_date = Date.parse(Time.now.strftime("%d/%m/%Y"))
    open_browser
  end
  
  after :all do
    close_browser
  end
  
  it "Should be able to view a list of service disruptions" do
    @b.a(:href, SERVICE_DISRUPTIONS).click
    
    fail unless @b.text.include? "Service disruptions"
  end
  
  it "Service disruptions should be up-to-date" do
    @b.goto "nationalrail.co.uk"
    
    @b.a(:href, SERVICE_DISRUPTIONS).click
    
    disrupts_table = @b.table(:class, 'accordian-table')
    
    disrupts = disrupts_table.tds(:class, 'first')
    
    disrupts.each do |disrupt|
      disrupt.click # expand the info pane for this disruption
      sleep(1) # wait for the pane to expand
    end
      
    disrupts = disrupts_table.dls(:class, 'zebra')
    
    disrupts.each do |disrupt| # check each disruption about when they were last updated
      date_updated = Date.parse((DATE.match(disrupt.dd(:index => 1).text)).to_s)
      
      fail unless @current_date - date_updated < 3 # days, which means it has been recently updated   
    end
  end
  
  it "Engineering Works should be up-to-date" do
    @b.goto "http://www.nationalrail.co.uk/service_disruptions/today.aspx"
    
    eng_works_table = @b.table(:class, 'accordian-table accordian-table-nh')
    
    eng_works = eng_works_table.tds(:class, 'first')
    
    eng_works.each do |eng_work|
      eng_work.click
      sleep(1)
    end
    
    eng_works = eng_works_table.dls(:class, 'zebra')
    
    eng_works.each do |eng_work|
      eng_works_until = Date.parse((DATE.match(eng_work.dd(:index => 1).text)).to_s)
      
      fail unless eng_works_until - @current_date > 0
    end
  end
end