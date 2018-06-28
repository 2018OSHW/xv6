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
    {GRID_RIVER,GRID_RIVER,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_FOREST,
    GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_FOREST},
    {GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_FOREST,
    GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_FOREST},
    {GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL},
    {GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_LAKE,GRID_ROAD,
        GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD},
    {GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL},
    {GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,
        GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD},
    {GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL},
    {GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,
        GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_MOUNTAIN,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD},
    {GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_STONE,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_STONE,GRID_STONE},
    {GRID_GRASS,GRID_GRASS,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_MOUNTAIN,GRID_ROAD,GRID_ROAD,
        GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD},
    {GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL}
};



bool wndProc(AHwnd hwnd, AMessage msg)
{
    //printf(1,"desktop processing!\n");
    switch(msg.type)
    {
	case MSG_DRAWMAINWINDOW:

            return False;
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
            {
                int off = j * GRID_W_NUMBER;
                for (int i = 0; i< GRID_W_NUMBER; i++)
                    hwnd->Grid[off + i] = desktop_layout[j][i];
            }
            msg.type = MSG_PAINT;
            APSendMessage(hwnd,msg);
            return False;
        case MSG_PAINT:
            APGridPaint(hwnd);
            break;
        case MSG_KEY_DOWN:
            printf(1,"kbd message received!\n");
            switch (msg.param)
        {
            case VK_RIGHT:
                changePosition(VK_RIGHT,0);
                break;
            default:break;
        }
            break;
        default: break;
            
            
            
    }
    return APWndProc(hwnd, msg);
}

int main(void)
{
    desktopInitStringFigure();
    AHwnd r = APCreateWindow("desktop",True,3);
    AHwnd hwnd = r;
    printf(1,"desktop initialized!\n");
    APWndExec(hwnd, wndProc);
    exit();
}
