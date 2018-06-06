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


int main(void)
{
    desktopInitStringFigure();
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    if (r == 0)
        APError(0);
    strcpy(r->title, "desktop");
    
    r->pos.x = 0;
    r->pos.y = 0;
    r->wholeDc.size.cx = SCREEN_WIDTH;
    r->wholeDc.size.cy = SCREEN_HEIGHT;
    r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    if (r->wholeDc.content == 0)
        APError(0);
    memset(r->wholeDc.content, 0x0c, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    
    r->clientPos.x = 0;
    r->clientPos.y = 0;
    r->dc.size.cx = SCREEN_WIDTH;
    r->dc.size.cy = SCREEN_HEIGHT ;
    r->dc.content = (AColor *)malloc(sizeof(AColor) * r->dc.size.cx * r->dc.size.cy);
    if (r->dc.content == 0)
        APError(0);
    memset(r->dc.content, 0x0, sizeof(AColor) * r->dc.size.cx * r->dc.size.cy);
    
    r->msg.type = MSG_NULL;
    r->state = 0;
    r->pid = getpid();
    r->msgQueueId = -1;
    
    r->parentId = -1;

    AHwnd hwnd = r;
    APWndExec(hwnd, wndProc);
    exit();
}
