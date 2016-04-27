//
//  CoreTextData.m
//  CoreTextDemo
//
//  Created by 卢良潇 on 16/4/25.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import "CoreTextData.h"

@implementation CoreTextData


- (void)setCtFrame:(CTFrameRef)ctFrame
    {
        if (_ctFrame != ctFrame) {
            if (_ctFrame != nil)
            {
                CFRelease(_ctFrame);
            }
            CFRetain(ctFrame);
            _ctFrame = ctFrame;
        }
        
    }

- (void)dealloc
{
    if (_ctFrame != nil) {
        CFRelease(_ctFrame);
        _ctFrame = nil;
    }
}


@end
