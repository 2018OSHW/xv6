#include "APDesktop.h"

void desktopInitStringFigure()
{
    printf(1, "init ASCII\n");
    int fd = open("ASCII", O_RDONLY);
    if (fd < 0)
    {
        printf(1, "Cannot open file\n");
        return;
    }
    char * ASCII = (char *)malloc(sizeof(char) * ASCII_SIZE);
    read(fd, ASCII, sizeof(char) * ASCII_SIZE);
    close(fd);
    printf(1, "read ASCII complete\n");
    
    initStringFigure(0, 0, ASCII, ASCII_SIZE);
    //free(GBK2312);
    free(ASCII);
    printf(1, "init string figure complete\n");
}


void runApp(void * param)
{
    int pid = fork();
    char temp[30];
    if (pid == 0)
    {
        sprintf(temp, "AP%s", (char *)param);
        char *argv[] = { temp, 0 };
        exec(temp, argv);
    }
}
