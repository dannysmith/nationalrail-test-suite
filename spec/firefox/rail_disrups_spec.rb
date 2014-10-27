require 'spec_helper'
require 'date'

describe "Checking rail disruptions" do
  before :all do
    run :firefox
    
    @current_date = Date.parse(Time.now.strftime("%d/%m/%Y"))
    
    generate_stations_list
  end
  
  before :each do
    goto_disruptions
  end
  
  after :all do
    close_browser
  end
  
  it "Should be able to view a list of service disruptions." do
    fail unless @b.text.include? "Service disruptions"
  end
  
  it "Service disruptions should be up-to-date." do    
    disrupts_table = @b.table(:class, 'accordian-table')
    
    unless disrupts_table[0].text.include? "There are currently no disruptions" # if there are disruptions
      disrupts_headers = disrupts_table.tds(class: 'first')
      disrupts_details = disrupts_table.trs(class: 'acc-c')

      disrupts_headers.each_with_index do |disrupts_header, index|
        disrupts_header.click # expand the info pane for this disruption

        disrupt_detail = disrupts_details[index].dds

        if disrupt_detail[index].div(class: 'exp-c clear expanded-content').exists?
          disrupt_until = Date.parse((DATE.match(disrupt_detail[1].when_present.text).to_s))

          fail unless disrupt_until - @current_date >= 0 # eng work end date must be set in the future
        end
      end
    end
  end
  
  it "Engineering Works should be up-to-date." do    
    eng_works_table = @b.table(:class, 'accordian-table accordian-table-nh')
    
    eng_works_headers = eng_works_table.tds(class: 'first')
    eng_works_details = eng_works_table.trs(class: 'acc-c')
    
    eng_works_headers.each_with_index do |eng_work_header, index|
      eng_work_header.click
      
      eng_work_detail = eng_works_details[index].dds
      
      if eng_work_detail[index].div(class: 'exp-c clear expanded-content').exists?
        eng_work_until = Date.parse((DATE.match(eng_work_detail[1].when_present.text).to_s))
      
        fail unless eng_work_until - @current_date >= 0 # eng work end date must be set in the future
      end
    end
  end
  
  it "service disruptions should be valid." do
    disrupts_table = @b.table(class: 'accordian-table')
    disrupts = disrupts_table.tds(class: 'first')
    
    disrupts_msgs = []
    disrupts.each do |disrupt|
      disrupts_msgs.push disrupt.text
    end
    
    disrupts_msgs.each do |msg|
      stations_mentioned = []
      
      @stations.each do |station|
        result = station.match msg
        
        if result != nil
          stations_mentioned.push result[0]
        end
      end
      
      if stations_mentioned.length > 2
        stations_mentioned.shift(2)
      end
      
      if stations_mentioned.length > 0
        goto_homepage
        
        if stations_mentioned.length == 2
          enter_destinations stations_mentioned[0], stations_mentioned[1]
          
          submit_journey_criteria
          
          expect(@b.a(class: 'status')).to exist
        
        elsif
          @b.text_field(id: 'train-form').set(stations_mentioned[0])
          
          @b.button(text: 'Show').when_present.click
          
          expect(@b.div(class: 'disruption').when_present.h3.text).to eq('Service updates')
        else
        end
        
        stations_mentioned.clear
      end
    end
  end
end
