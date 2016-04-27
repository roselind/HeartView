//
//  CTFrameParser.m
//  CoreTextDemo
//
//  Created by 卢良潇 on 16/4/25.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import "CTFrameParser.h"
#import "CTFrameParserConfig.h"
#import <CoreText/CoreText.h>


@implementation CTFrameParser


+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config
{
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpacing = config.lineSpace;
    const CFIndex kNumberOfSetting = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSetting] =
    {
        {
            kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing
            },{
                kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat), &lineSpacing
            
        },{
            kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing
        }
    
    };
    
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSetting);
    
    UIColor *textColor = config.textColor;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    return dict;

}



+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config
{
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSAttributedString *contentString = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    //创建实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)contentString);
    //获取要绘制区域的高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    //生成实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
    //保存到coretextdata实例
    CoreTextData *data = [[CoreTextData alloc]init];
    data.ctFrame = frame;
    data.height = textHeight;
    
    
    // 释放内存
    CFRelease(frame);
    CFRelease(framesetter);
    return data;

    
}


+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter
                                  config:(CTFrameParserConfig *)config
                                  height:(CGFloat)height {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}



@end
