c-functions
create: command threadHandle: handle
		^ self ffiCall: #(int run_command_child #(IntegerPointer handle, char * command)) module: Pty 