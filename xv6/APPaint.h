//
//  APPaint.h
//  
//
//  Created by Poo Lei on 2018/6/6.
//

#ifndef APPaint_h
#define APPaint_h
#include "APObject.h"


ABitmap APLoadBitmap(char * filename);

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp);


#endif /* APPaint_h */
