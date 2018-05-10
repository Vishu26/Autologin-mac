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

repeat
	tell application "Safari"
		if not (exists document 1) then reopen
		tell current tab of window 1 to set URL to "https://10.100.56.55:8090"
		
		set the_state to missing value
		repeat until the_state is "complete"
			set the_state to (do JavaScript "document.readyState" in document 1)
			log "busy"
			delay 0.2
		end repeat
		log "complete"
	end tell
	inputByName("username", 0, "201601016")
	inputByName("password", 0, "abcdefg")
	clickName("btnSubmit", 0)
	delay 5400
end repeat