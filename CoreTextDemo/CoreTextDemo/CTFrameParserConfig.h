//
//  CTFrameParserConfig.h
//  CoreTextDemo
//
//  Created by 卢良潇 on 16/4/25.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+frameAdjust.h"

@interface CTFrameParserConfig : NSObject

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat fontSize;

@property (nonatomic,assign) CGFloat lineSpace;
@property (nonatomic,strong) UIColor *textColor;

@end
