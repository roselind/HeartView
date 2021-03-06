//
//  CTFrameParser.h
//  CoreTextDemo
//
//  Created by 卢良潇 on 16/4/25.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextData.h"
#import "CTFrameParserConfig.h"
#import "UIView+frameAdjust.h"

@interface CTFrameParser : NSObject

+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;
+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config;

@end
