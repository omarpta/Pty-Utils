as yet unclassified
sendCtrlD: pty
		^ self ffiCall: #(void send_ctrl_d #(int pty)) module: Pty 