operations
readUntil: aTarget
	| isForRead textByte text |
	
	isForRead := true.
	[ isForRead ]
		whileTrue: [
			(Delay forMilliseconds: 50) wait.
			textByte := StringPointer new.			 
			LibPtyUtils with: pty readText: textByte.
			text := textByte value .  
			(text isNotNil and: [text isNotEmpty ]) ifTrue: [
	"			Transcript show: text.  
	"		
				((text findString: aTarget) > 0) 
					ifTrue: [ isForRead := false. ].
					
			].
			
		].