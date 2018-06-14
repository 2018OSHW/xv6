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


//16x11
int desktop_layout[GRID_H_NUMBER][GRID_W_NUMBER]=
{
    {GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
    GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL},
    {GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,
    GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD},
    {GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL},
    {GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,
        GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD},
    {GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL},
    {GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,
        GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD},
    {GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL},
    {GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,
        GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD},
    {GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL},
    {GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,
        GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD},
    {GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL}
};



bool wndProc(AHwnd hwnd, AMessage msg)
{
    switch(msg.type)
    {
	case MSG_DRAWMAINWINDOW:

		break;
        
        case MSG_INIT:
            //init
            int off;
            for (int j = 0; j < GRID_H_NUMBER; j++)
            {
                off = j * GRID_W_NUMBER;
                for (int i = 0; i< GRID_W_NUMBER; i++)
                    hwnd->Grid[off + i] = desktop_layout[i][j];
            }
            msg.type = MSG_PAINT;
            APSendMessage(hwnd,msg);
            return False;
        case MSG_PAINT:
            APGridPaint(hwnd);
            break;
        default: break;
            
            
            
    }
    return APWndProc(hwnd, msg);
}

int main(void)
{
    desktopInitStringFigure();
    
    AHwnd r = APCreateWindow("desktop",True,3,True,1);
    
    /*
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    if (r == 0)
        cprintf("desktop creation failed!\n");
    strcpy(r->title, "desktop");
    
    //create window
    r->pos.x = 0;
    r->pos.y = 0;
    r->wholeDc.size.cx = SCREEN_WIDTH;
    r->wholeDc.size.cy = SCREEN_HEIGHT;
    r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    if (r->wholeDc.content == 0)
        printf(1,"whole dc error");
    memset(r->wholeDc.content, 0x0c, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    
    r->clientPos.x = 0;
    r->clientPos.y = 0;
    r->Dc.size.cx = SCREEN_WIDTH;
    r->Dc.size.cy = SCREEN_HEIGHT ;
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    if (r->Dc.content == 0)
        printf(1,"dc error");
    memset(r->Dc.content, 0x0c, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    
    r->msg.type = MSG_NULL;
    r->state = 0;
    r->pid = getpid();
    r->msgQueueID = -1;
    
    r->parentID = -1;
*/
    AHwnd hwnd = r;
    cprintf("desktop initialized!\n");
    APWndExec(hwnd, wndProc);
    exit();
}
