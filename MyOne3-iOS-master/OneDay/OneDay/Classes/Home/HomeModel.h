//
//  HomeModel.h
//  OneDay
//
//  Created by 卢良潇 on 16/4/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel


@property (nonatomic, copy) NSString *contentId;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *imageOriginalURL;
@property (nonatomic, copy) NSString *authorId;
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, copy) NSString *iPadURL;
@property (nonatomic, copy) NSString *makeTime;
@property (nonatomic, copy) NSString *lastUpdateDate;
@property (nonatomic, copy) NSString *webURL;
@property (nonatomic, copy) NSString *wbImageURL;
@property (nonatomic, assign) NSInteger praiseNum;
@property (nonatomic, assign) NSInteger shareNum;
@property (nonatomic, assign) NSInteger commentNum;

@end
