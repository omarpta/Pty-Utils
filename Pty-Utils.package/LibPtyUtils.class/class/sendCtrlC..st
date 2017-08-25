c-functions
sendCtrlC: pty
		^ self ffiCall: #(void send_ctrl_c #(int pty)) module: LibPtyUtils 