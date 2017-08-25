construction
newCommand: aCommand
	| instance pid |
	instance := self new.
	pid := IntegerPointer new.
	instance pty: (LibPtyUtils create: aCommand threadHandle: pid).
	instance pid: pid value .
	^ instance . 