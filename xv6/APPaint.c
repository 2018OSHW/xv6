//
//  APPaint.c
//  
//
//  Created by Poo Lei on 2018/6/6.
//

#include "APPaint.h"
#include "user.h"
#include "fcntl.h"
#include "types.h"
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
}

static inline int abs_int(int x)
{
    return (x >= 0)? x :-x;
}

static inline double abs_double(double x)
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    if (x < 0)
        return X_SMALLER;
    else if (x >= hdc->size.cx )
        return X_BIGGER;
    if (y < 0)
        return Y_SMALLER;
    else if (y>=hdc->size.cy)
        return Y_BIGGER;
    return y * hdc->size.cx + x;
}

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    bmp.data = 0;
    int fd = open(filename, O_RDONLY);
    if (fd < 0)
    {
        printf(1, "Cannot open %s\n", filename);
        return bmp;
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    bmp.width = infoHeader.biWidth;
    bmp.height = infoHeader.biHeight;
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    int c = infoHeader.biBitCount;
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    return bmp;
}

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    hdc->pen.size = 0;
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    hdc->size.cx = bmp.width;
    hdc->size.cy = bmp.height;
    hdc->content = bmp.data;
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
}

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    APen r = hdc->pen;
    hdc->pen = pen;
    return r;
}

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    ABrush r = hdc->brush;
    hdc->brush = brush;
    return r;
}


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    int i, j, t;
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
        if (y1 > y2)
        {
            int tmp = y2;
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
            APDrawPoint(hdc,x1,j);
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
        if (x1 > x2)
        {
            int tmp = x2;
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
            APDrawPoint(hdc,i,y1);
        return;
    }
    
    int s = 0,e = 0;
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
        if (x2 > x1)
        {
            s = x1;
            e = x2;
        }
        else
        {
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    if (y1 > y2)
    {
        s = y2;
        e = y1;
    }
    else
    {
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    APDrawLine(hdc,x,y,x+w-1,y);
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    
    if (x < 0) x = 0;
    if (y < 0) y = 0;
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y; j++)
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}






