//
//  BaseView.h
//  OneDay
//
//  Created by 卢良潇 on 16/4/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseViewController;

@interface BaseView : UIView

@property (nonatomic, weak) BaseViewController *parentViewController;
@property (nonatomic, assign) NSInteger viewIndex;

@end
