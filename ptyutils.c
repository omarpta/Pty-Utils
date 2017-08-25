#include "ptyutils.h"


int run_command_child(int *child, char * str)
{
    int pty;
    *child = forkpty(&pty, 0, 0, 0);
    if (*child == -1)
    {
        perror("forkpty() error");
        return -1;
    }


    if (!*child)
    {
        system(str);
        exit(-1);
    }

    if (DEBUG)
        fprintf(stderr, "PTY:%d CHILD:%d - %s\n", pty, *child, str);

    int flags = fcntl(pty, F_GETFL, 0);
    fcntl(pty, F_SETFL, flags | O_NONBLOCK);
    return pty;
}


void get_text(int pty, char ** text)
{
    int ret;
    char buffer[1020];
    *text = NULL;
    fd_set fds;
    FD_ZERO(&fds);
    FD_SET(pty, &fds);
    struct timeval timeout;
    timeout.tv_sec = 0;
    timeout.tv_usec = 100;

    if (select(pty+1, &fds, 0, 0, &timeout)==1)
    {

        ret = read(pty, buffer, sizeof (buffer));
        if (ret > 0 && ret < sizeof (buffer))
        {
            buffer[ret] = 0;
        }

        *text = (char*) malloc(sizeof(buffer));
        strcpy(*text, buffer);
    }
    memset(buffer, '\0', sizeof (buffer));
}

void send_text(int pty, char *text)
{
    if (DEBUG)
        fprintf(stderr, "PTY: %d - %s\n", pty, text);
    write(pty, text, strlen(text) + 1);
}


int wait_finish(int child)
{
    int ret;
    waitpid(child, &ret, 0);
    return ret;
}

void send_ctrl_c(int pty)
{
    int ctrl_c = 0x03;
    if (DEBUG)
        fprintf(stderr, "PTY: %d - CTRL+C Sent.\n", pty);
    write(pty, &ctrl_c,1);
}
void send_ctrl_d(int pty)
{
    int ctrl_d = 0x04;
    if (DEBUG)
        fprintf(stderr, "PTY: %d - CTRL+D Sent.\n", pty);
    write(pty, &ctrl_d,1);
}
