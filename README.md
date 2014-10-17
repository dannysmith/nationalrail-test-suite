# National Rail Test Suite - Version 0.1 - 15/10/14

This is a suite of automated tests for the national rail website written using RSpec and Watir across three browsers - Firefox, Chrome and IE. 

For use with Ruby 1.9.3 

## Structure 

##### Data 
* test_data 
* uk_stations_list

##### Documentation
* users stories 
* personas 

##### Screenshots(itinerary_spec saves screenshots into this folder)

##### Spec 
* chrome 
    - itinerary_spec 
    
* firefox 
    - arrivals_spec 
    - group_tickets_spec
    - purchase_spec 
    - rail_disruptions_spec 
    - specialoffers_spec
* spec_helper 
* spec_helperchrome

##### Gemfile
##### Rakefile
##### README


## How to install 

This project uses Ruby and Watir to automate tests.

This project will use ChromeDriver. To install ChromeDriver go to [ChromeDriver download](http://chromedriver.storage.googleapis.com/index.html) and choose the correct version.

Put the .exe file in your Ruby bin folder, run it from the cmdline and add the file to your PATH by going to control panel - system - advanced system settings - environment variables - edit path and add file location. You should be all set up to go.

#### To run

This project uses RSpec and Watir so you will need to install the Rubygems for it or run bundler from your cmdline:

```ruby
bundle install
``` 

Then from your cmdline run the tests with Rake. To do this do
```ruby
rake tests
or
rake chrometests
```
or if you want to run one test individually
```ruby
rspec \spec\filetorun_spec.rb
```

