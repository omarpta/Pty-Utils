tests
testTail
	| pty isForRead textByte text child "commandSent" command "commandToRun target" |
	
	command := 'tail -f /home/omar/omar.txt'.
	
	
	child := IntegerPointer new.
	pty := LibPtyUtils
		create: command threadHandle: child .
	
	isForRead := true.
	[ [ isForRead ]
		whileTrue: [
			(Delay forMilliseconds: 5000) wait.
			textByte := StringPointer new.			 
			LibPtyUtils with: pty readText: textByte.
			text := textByte value .  
			(text isNotNil and: [((text size) > 0)]) ifTrue: [
				Transcript show: text.  
				LibPtyUtils sendCtrlC: pty.
				isForRead := false.
			]
			
		].
	LibPtyUtils waitThreadFinish: child value.	
	] fork.
