#ifndef APOBJECT_H_
#define APOBJECT_H_

#include "types.h"


typedef struct Pos
{
    uint x,y;               //pos x,y
};

typedef struct APPos
{
    struct Pos scene;       //pos x,y in the scene
    struct Pos view;        //pos x,y in the view (view is the window)
};

struct Pos get_view_pos(strucpt APPos item, struct APPos window);


typedef struct AColor
{
    uchar r;
    uchar g;
    uchar b;
};

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    AColor rgb;
    rgb.r = r;
    rgb.g = g;
    rgb.b = b;
    return rgb;
}

typedef struct ABitmap
{
    uint width;
    uint height;
    AColor *data;
}

#endif
