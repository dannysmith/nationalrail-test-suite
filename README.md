# National Rail Test Suite - Version 0.1 - 15/10/14

This is a suite of automated tests for the national rail website written using RSpec and Watir.

## Overview

* Automated test cases using Rspec and Watir.

## How to install 

This project uses Ruby and Watir to automate tests.

This project will use ChromeDriver. To install ChromeDriver go to [ChromeDriver download](http://chromedriver.storage.googleapis.com/index.html) and choose the correct version.


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
rspec .\spec\filetorun_spec.rb
```
