
#ifndef APPOS_H_
#define APPOS_H_

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


#endif
