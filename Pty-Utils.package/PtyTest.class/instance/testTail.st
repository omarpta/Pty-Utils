tests
testTail
	| pty isForRead textByte text child "commandSent" command "commandToRun target" |
	
	command := 'tail -f /home/omar/omar.txt'.
	
	
	child := IntegerPointer new.
	pty := Pty
		create: command threadHandle: child .
	
	isForRead := true.
	[ [ isForRead ]
		whileTrue: [
			(Delay forMilliseconds: 50) wait.
			textByte := StringPointer new.			 
			Pty with: pty readText: textByte.
			text := textByte value .  
			(text isNotNil and: [((text size) > 0)]) ifTrue: [
				Transcript show: (pty asString) , ' - ', (child value asString).
				Transcript show: text.  
			]
			
		].
	Pty waitThreadFinish: child value.	
	] fork.
