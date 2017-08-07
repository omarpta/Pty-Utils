main-tests
testSsh
	| pty isForRead textByte text child commandSent command password commandToRun target |
	"command := 'ssh -oConnectTimeout=3 -oStrictHostKeyChecking=no root@10.26.30.183'.
	password := 'vivo@2017'. 
	commandToRun := 'ls -lahrt /usr/lib64/ && service --status-all'.
	target := ']#'."
	
	
	command := 'ssh -oConnectTimeout=3 -oStrictHostKeyChecking=no omarpta@sdf.org'.
	password := 'oMirueira01%'. 
	commandToRun := 'ls -lahrt'.
	target := ']$'.
	
	commandSent := false.
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
				Transcript show: text.  
			
				((text findString: 'password:') > 0) 
					ifTrue: [
						Pty	with: pty sendText: password, String lf.]
					ifFalse: [
				((text findString: target) > 0)
					ifTrue: [
						(commandSent) 
						ifTrue: [ Pty	with: pty sendText: 'exit', String lf. ]
						ifFalse: [ Pty	with: pty sendText: commandToRun, String lf. commandSent := true.] 
						
						] 
					ifFalse:[
				(((text findString: 'closed.') > 0) | ((text findString: 'Killed') > 0) | ((text findString: 'Connection timed out') > 0))
					ifTrue: [
						Transcript show: 'PTY END', String lf.
						isForRead := false.]
				]]
			]
			
		].
	Pty waitThreadFinish: child value.	
	] fork.
	
