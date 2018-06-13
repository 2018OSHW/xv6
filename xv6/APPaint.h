//
//  APPaint.h
//  
//
//  Created by Poo Lei on 2018/6/6.
//

#ifndef APPaint_h
#define APPaint_h

#include "APObject.h"


struct ABitmap APLoadBitmap (char * filename);

struct AHdc APCreateCompatibleDCFromBitmap(struct ABitmap bmp);


#endif /* APPaint_h */
