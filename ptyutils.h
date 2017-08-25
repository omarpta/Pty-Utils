#ifndef PTYUTILS_H_INCLUDED
#define PTYUTILS_H_INCLUDED
#include <pty.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/time.h>
#include <sys/select.h>
#define DEBUG 0
int run_command_child(int *child, char * str);
void get_text(int pty, char ** text);
void send_text(int pty, char *text);
int wait_finish(int child);
void send_ctrl_c(int pty);
void send_ctrl_d(int pty);
#endif // PTYUTILS_H_INCLUDED
