operations
with: pty sendText: text
		^ self ffiCall: #(int send_text #(int pty, char * text)) module: Pty 