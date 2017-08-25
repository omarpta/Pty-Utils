c-functions
stopPtyThread: pty
	(Process allSubInstances select: [:each | each name = ('PTY_THREAD_', pty asString)]) do: [ :each | 
		each terminate .
	].
	LibPtyUtils killThread: pty.
	LibPtyUtils waitThreadFinish: pty.
	"Transcript cr; show: 'PTY_END'; cr."