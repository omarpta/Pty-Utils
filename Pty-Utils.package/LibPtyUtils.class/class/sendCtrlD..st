c-functions
sendCtrlD: pty
		^ self ffiCall: #(void send_ctrl_d #(int pty)) module: LibPtyUtils 