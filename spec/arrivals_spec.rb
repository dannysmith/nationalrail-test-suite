require 'spec_helper'
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
    	
	# Test 1 - Search for multiple stations. Searching for 3 stations, after this it is assumed that it will work for all UK stations.
  it "Allow searches to different UK stations" do
    place1 = "Richmond (London)"
    place2 = "Glasgow Central"
    place3 = "Cardiff Central"
		
    @b.a(:title, 'Train times & tickets').click
        
    @b.a(:title, 'Live departure boards').click
    @b.text_field(:id, 'train-from').click
    @b.text_field(:id, 'train-from').clear
    @b.text_field(:id, 'train-from').send_keys(place1)
    @b.button(:id, 'planJourney').click
    @b.h1(:class, 'sifr').wait_until_present

    expect(@b.div.li(:class, 'departing active').text.include?("Departing")).to eq(true)
    expect(@b.h2.text.include?(place1)).to eq(true)

    @b.a(:title, 'Live departure boards').click
    @b.text_field(:id, 'train-from').click
    @b.text_field(:id, 'train-from').clear
    @b.text_field(:id, 'train-from').send_keys(place2)
    @b.button(:id, 'planJourney').click
    @b.h1(:class, 'sifr').wait_until_present
        
	expect(@b.h2.text.include?(place2)).to eq(true)
		
	@b.a(:title, 'Live departure boards').click
    @b.text_field(:id, 'train-from').click
    @b.text_field(:id, 'train-from').clear
    @b.text_field(:id, 'train-from').send_keys(place3)
    @b.button(:id, 'planJourney').click
    @b.h1(:class, 'sifr').wait_until_present
	expect(@b.h2.text.include?(place3)).to eq(true)
  end
	
	# Test 2 - Departures
  it "Show departures for Richmond station" do
    place = "Richmond (London)"
        
    @b.a(:title, 'Train times & tickets').click
    
    @b.a(:title, 'Live departure boards').click
    @b.text_field(:id, 'train-from').click
    @b.text_field(:id, 'train-from').clear
    @b.text_field(:id, 'train-from').send_keys(place)
    @b.button(:id, 'planJourney').click
    @b.h1(:class, 'sifr').wait_until_present

    expect(@b.div.li(:class, 'departing active').text.include?("Departing")).to eq(true)   
    expect(@b.h2.text.include?(place)).to eq(true)    
  end
    
    # Test 3 - Arrivals
  it "Show arrivals for Richmond station" do
    place = "Richmond (London)"
        
    @b.a(:title, 'Train times & tickets').click
      
    @b.a(:title, 'Live departure boards').click
    @b.a(:class, 'ldb-r ldb-arrivals').click  
    @b.text_field(:id, 'train-from').click
    @b.text_field(:id, 'train-from').clear
    @b.text_field(:id, 'train-from').send_keys(place)
    @b.button(:id, 'planJourney').click
    @b.h1(:class, 'sifr').wait_until_present
        
    expect(@b.div.li(:class, 'arriving active').text.include?("Arriving")).to eq(true)
    expect(@b.h2.text.include?(place)).to eq(true)  
  end
end
