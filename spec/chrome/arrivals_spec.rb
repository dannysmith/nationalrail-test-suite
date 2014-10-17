require 'spec_helperchrome'
require 'watir'

describe "Live Arrival/Departures Tests" do
  before :all do
    open_browser
  end
    
  after :each do
    return_homepage
  end

  after :all do
    close_browser
  end

  PLACE1 = "Richmond (London)"
  PLACE2 = "Glasgow Central"
  PLACE3 = "Cardiff Central"
    	
# Test 1 - Search for multiple stations. Searching for 3 stations, after this it is assumed that it will work for all UK stations.
  it "Allow searches to different UK stations" do
		
    @b.element(:title, 'Train times & tickets').click
        
    @b.element(:title, 'Live departure boards').click
    @b.text_field(:id, 'train-from').send_keys(PLACE1)
    @b.button(:id, 'planJourney').click
    @b.h1(:class, 'sifr').wait_until_present

    expect(@b.div.li(:class, 'departing active').text.include?("Departing"))
    expect(@b.h2.text.include?(PLACE1))

    @b.a(:title, 'Live departure boards').click
    @b.text_field(:id, 'train-from').send_keys(PLACE2)
    @b.button(:id, 'planJourney').click
    @b.h1(:class, 'sifr').wait_until_present
        
	  expect(@b.h2.text.include?(PLACE2))
    		
	  @b.element(:title, 'Live departure boards').click
    @b.text_field(:id, 'train-from').send_keys(PLACE3)
    @b.button(:id, 'planJourney').click
    @b.h1(:class, 'sifr').wait_until_present
	  expect(@b.h2.text.include?(PLACE3))
  end
	
	# Test 2 - Departures
  it "Show departures for Richmond station" do
        
    @b.element(:title, 'Train times & tickets').click
    
    @b.element(:title, 'Live departure boards').click
    @b.text_field(:id, 'train-from').send_keys(PLACE1)
    @b.button(:id, 'planJourney').click
    @b.h1(:class, 'sifr').wait_until_present

    expect(@b.div.li(:class, 'departing active').text.include?("Departing"))   
    expect(@b.h2.text.include?(PLACE1))    
  end
    
    # Test 3 - Arrivals
  it "Show arrivals for Richmond station" do
        
    @b.element(:title, 'Train times & tickets').click
      
    @b.element(:title, 'Live departure boards').click
    @b.element(:class, 'ldb-r ldb-arrivals').click  
    @b.text_field(:id, 'train-from').send_keys(PLACE1)
    @b.button(:id, 'planJourney').click
    @b.h1(:class, 'sifr').wait_until_present
        
    expect(@b.div.li(:class, 'arriving active').text.include?("Arriving"))
    expect(@b.h2.text.include?(PLACE1))
  end
end
