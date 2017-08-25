construction
newCommand: aCommand readUntil: aTarget
	| instance |
	instance := self newCommand: aCommand.
	instance readUntil: aTarget .
	
	^ instance . 