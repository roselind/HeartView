//
//  HomeModel.m
//  OneDay
//
//  Created by 卢良潇 on 16/4/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"contentId" : @"hpcontent_id",
             @"content" : @"hp_content",
             @"title" : @"hp_title",
             @"imageURL" : @"hp_img_url",
             @"imageOriginalURL" : @"hp_img_original_url",
             @"authorId" : @"author_id",
             @"authorName" : @"hp_author",
             @"iPadURL" : @"ipad_url",
             @"makeTime" : @"hp_makettime",
             @"lastUpdateDate" : @"last_update_date",
             @"webURL" : @"web_url",
             @"wbImageURL" : @"wb_img_url",
             @"praiseNum" : @"praisenum",
             @"shareNum" : @"sharenum",
             @"commentNum" : @"commentnum"};
}



@end
