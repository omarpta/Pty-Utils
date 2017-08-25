c-functions
with: pty sendText: text
		^ self ffiCall: #(void send_text #(int pty, char * text)) module: Pty 