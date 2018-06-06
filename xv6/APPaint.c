//
//  APPaint.c
//  
//
//  Created by Poo Lei on 2018/6/6.
//

#include "APPaint.h"


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
