require 'watir'
require 'spec_helper'
require 'date'

describe "Checking rail disruptions" do
  before :each do
    open_browser
  end
  
  after :each do
    close_browser
  end
  
  #it "Should be able to view service disruptions" do
   # @b.a(:href, service_disruption).click
    
    #fail unless @b.text.include? "Service disruptions"
  #end
  
  it "Service disruptions should be up-to-date" do
    current_date = Date.parse(Time.now.strftime("%d/%m/%Y"))
    
    @b.a(:href, SERVICE_DISRUPTIONS).click
    
    disrupts_table = @b.table(:class, 'accordian-table')
    
    disrupts = disrupts_table.tds(:class, 'first')
    num_of_disrupts = disrupts.length
    
    disrupts.each do |disrupt|
      disrupt.click # expand the info pane for this disruption
      sleep(1) # wait for the pane to expand
    end
      
    disrupts = @b.dls(:class, 'zebra')
    
    0.upto(num_of_disrupts-1) do |index| # check each disruption about when they were last updated
      date_updated = Date.parse((DATE.match(disrupts[index].dd(:index => 1).text)).to_s)
      
      fail unless current_date - date_updated < 3 # days, which means it has been recently updated   
    end
  end
end