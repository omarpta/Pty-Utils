c-functions
waitThreadFinish: handle
		^ self ffiCall: #(int wait_finish #(int handle)) module: Pty 