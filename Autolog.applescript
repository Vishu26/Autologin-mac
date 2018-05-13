to inputByName(theName, num, theValue)
	
	tell application "Safari"
		
		do JavaScript " 

  document.getElementsByName('" & theName & "')[" & num & "].value ='" & theValue & "';" in document 1
		
	end tell
	
end inputByName

to clickName(theName, elementnum)
	
	tell application "Safari"
		
		do JavaScript "document.getElementsByName('" & theName & "')[" & elementnum & "].click();" in document 1
		
	end tell
	
end clickName

set paragraph_list to read file "log.txt" using delimiter linefeed
set user to item 1 of paragraph_list
set pass to item 2 of paragraph_list

repeat
	tell application "Safari"
		if not (exists document 1) then reopen
		tell window 1
			set current tab to (make new tab with properties {URL:"https://10.100.56.55:8090"})
		end tell
		
		-- tell current tab of window 1 to set URL to "https://10.100.56.55:8090"
		
		set the_state to missing value
		repeat until the_state is "complete"
			set the_state to (do JavaScript "document.readyState" in document 1)
			log "busy"
			delay 0.2
		end repeat
		log "complete"
	end tell
	inputByName("username", 0, user)
	inputByName("password", 0, pass)
	clickName("btnSubmit", 0)
	delay 5400
end repeat
