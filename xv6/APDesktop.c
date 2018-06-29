#include "APDesktop.h"

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
    {GRID_RIVER,GRID_ROAD,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_FOREST,
    GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_FOREST},
    {GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_FOREST,
    GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_FOREST},
    {GRID_WALL,GRID_ROAD,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL},
    {GRID_ROAD,GRID_PROGRAM_SNAKE,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_LAKE,GRID_ROAD,
        GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD},
    {GRID_WALL,GRID_ROAD,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL},
    {GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,
        GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD},
    {GRID_WALL,GRID_ROAD,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL},
    {GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,
        GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_MOUNTAIN,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD},
    {GRID_WALL,GRID_ROAD,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_STONE,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_STONE,GRID_STONE},
    {GRID_GRASS,GRID_GRASS,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_MOUNTAIN,GRID_ROAD,GRID_ROAD,
        GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD,GRID_ROAD},
    {GRID_WALL,GRID_ROAD,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,
        GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL,GRID_WALL}
};



bool wndProc(AHwnd hwnd, AMessage msg)
{
    //printf(1,"desktop processing!\n");
    switch(msg.type)
    {
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
            {
                int off = j * GRID_W_NUMBER;
                for (int i = 0; i< GRID_W_NUMBER; i++)
                    hwnd->Grid[off + i] = desktop_layout[j][i];
            }
            hwnd->pos_x = 3;
            hwnd->pos_y = 3;
            msg.type = MSG_PAINT;
            APSendMessage(hwnd,msg);
            //setupTimer(hwnd,0,1000);
            return False;
        case MSG_PAINT:
            APGridPaint(hwnd);
            break;
        case MSG_KEY_DOWN:
            //printf(1,"kbd message received!\n");
            switch (msg.param)
        {
            case VK_RIGHT:
                if (hwnd->pos_x < GRID_W_NUMBER - 1 && judgeGridWalkable(hwnd->pos_x + 1,hwnd->pos_y,hwnd))
                    hwnd->pos_x++;
                changePosition(hwnd->pos_x,hwnd->pos_y,1);
                break;
            case VK_LEFT:
                if (hwnd->pos_x > 0 && judgeGridWalkable(hwnd->pos_x - 1 ,hwnd->pos_y,hwnd))
                    hwnd->pos_x--;
                changePosition(hwnd->pos_x,hwnd->pos_y,0);
                break;
            case VK_UP:
                if (hwnd->pos_y > 0 && judgeGridWalkable(hwnd->pos_x ,hwnd->pos_y - 1,hwnd))
                    hwnd->pos_y--;
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
                break;
            case VK_DOWN:
                if (hwnd->pos_y < GRID_H_NUMBER - 1 && judgeGridWalkable(hwnd->pos_x ,hwnd->pos_y + 1,hwnd))
                    hwnd->pos_y++;
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
                break;
            case VK_ENTER:
                if (hwnd->Grid[hwnd->pos_y * GRID_W_NUMBER + hwnd->pos_x] == GRID_PROGRAM_SNAKE)
                    runApp("Snack");
                break;
            default:break;
        }
            break;
        default: break;
    }
    return APWndProc(hwnd, msg);
}

int judgeGridWalkable(int x,int y, AHwnd hwnd)
{
    if (hwnd->is_grid)
    {
        int index = hwnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER + y * GRID_W_NUMBER + x;
        switch(hwnd->Grid[index])
        {
                
            case GRID_WALL : return 0;
            case GRID_ROAD : return 1;
            case GRID_GRASS : return 1;
            case GRID_RIVER : return 0;
            case GRID_FOREST: return 0;
            case GRID_STONE: return 1;
            case GRID_MOUNTAIN: return 0;
            case GRID_LAKE: return 0;
            default: return 1;
        }
    }
    return 0;
}

int main(void)
{
    //runApp("MagicTower");
    AHwnd hwnd = APCreateWindow("desktop",True,3);
   //printf(1,"desktop initialized!\n");
    APWndExec(hwnd, wndProc);
    exit();
}
