operations
with: pty readText: text
		^ self ffiCall: #(int get_text #(int pty, StringPointer * text)) module: Pty 
	