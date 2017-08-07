operations
waitThreadFinish: handle
		^ self ffiCall: #(int wait_finish #(int handle)) module: Pty 