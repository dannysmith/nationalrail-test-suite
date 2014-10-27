#Format Document for National Rail RSpec

##Format:


###Double Space
```
  |
    |
```

###Variables:

```
  $ b. =  Browser
```

###Constants:

```
  $ FROM = “Beginning of Journey”
  $ TO = “Destination of Journey”
```

###Methods for opening and closing browser are in spec helper

  * Open Browser: 
  
    `$ open_browser`
      
  * Close Browser:
  
    `$ close_browser`
    
  * Return to homepage:
  
    `$ return_homepage`

###Methods for entering repeatable information

  * Used to enter the Journey Beginning to Ending:
  
	 `$ enter_destinations from, to`
   
  * Used to enter the Number of Passengers for the Journey
  
	 `$ set_no_of_passengers num_of_passengers`
   
  * Used to Randomly Insert Stations into the Journey To: and From:
  
	 `$ generate_stations_list`
   
  * Used to Enter in Correct login details 
  
    `$ enter_login_details`
    
  * Used to enter in known incorrect login details for test purposes
  
    `$ enter_wrong_login_details`
  
  * Used to logout of the Website
  
    `$ logout`
  
###Methods for click repeatedly used buttons

  * Used to Confirm Journey (Go Button)
  
	 `$ confirm_journey`
   
  * Used to click the first available Journey after Confirming Journey (Testing Purposes)
  
	 `$ click_first_matching_journey_result`

