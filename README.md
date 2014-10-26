# National Rail Test Suite - Version 0.1 - 15/10/14

This is a suite of automated tests for the national rail website written using RSpec and Watir across three browsers - Firefox and Chrome. 

Tested for use with Ruby 1.9.3 
This should work with later versions, if not. Please get in contact.

Requirements:

* gem 'rspec'
* gem 'watir'
* gem 'pry'

## How to install 

This project uses Ruby and Watir to automate tests.

This project will use ChromeDriver. To install ChromeDriver go to [ChromeDriver download](http://chromedriver.storage.googleapis.com/index.html) and choose the correct version.

Put the .exe file in your Ruby bin folder, run it from the cmdline and add the file to your PATH by going to control panel - system - advanced system settings - environment variables - edit path and add file location. You should be all set up to go.

## To run

This project uses RSpec and Watir so you will need to install the Rubygems for it or run bundler from your cmdline:

```ruby
bundle install
``` 

Then from your cmdline run the tests with Rake. To do this do
```ruby
rake tests:all # To run all tests
or
rake tests:chrome # To run all chrome tests
or
rake tests:ff # To run all ff tests
```
or if you want to run one test individually
```ruby
rspec \spec\folder\filetorun_spec.rb
```
To pull the latest station list from Wikipedia run this:
```ruby
rake update:stations # Runs the update stations program
```
## Code Format
This is the section which holds the code format that the coders would adjhere too and be checked against
[Format Code](./documentation/code_format.md)

## Contact Details

If there any questions feel free to contact us at:

dkent@testingcircle.com

tgohil@testingcircle.com

amuir@testingcircle.com

jkempton@testingcircle.com

rledesma@testingcircle.com


