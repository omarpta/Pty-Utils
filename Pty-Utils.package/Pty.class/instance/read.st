operations
read
	| text textByte |
	(Delay forMilliseconds: 50) wait.
	textByte := StringPointer new.			 
	LibPtyUtils with: pty readText: textByte.
	text := textByte value .
	^ text.