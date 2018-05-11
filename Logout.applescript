set myProcesses to {"Autolog"} -- The ones to quit.

tell application "System Events"
	repeat with myProcess in myProcesses
		set theID to (unix id of processes whose name is myProcess)
		try
			-- Should stop the application with no dialogs and no items saved.
			do shell script "kill -9 " & theID
		end try
	end repeat
end tell

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
inputByName("username", 0, user)
inputByName("password", 0, pass)
clickName("btnSubmit", 0)
delay 1
clickName("btnSubmit", 0)

-- Close the tab

tell application "Safari"
    repeat with t in tabs of windows
        tell t
            if name starts with "TabName" then close
        end tell
    end repeat
end tell
