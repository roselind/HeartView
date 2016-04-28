//
//  HomeView.h
//  OneDay
//
//  Created by 卢良潇 on 16/4/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import "BaseView.h"

FOUNDATION_EXPORT NSString *const HomeViewID;

@class HomeModel;

@interface HomeView : BaseView


@property (nonatomic, copy) void (^clickedButton)(ActionType type);

- (void)setViewWithHomeItems:(HomeModel *)item atIndex:(NSInteger)index;

- (void)setViewWithHomeItems:(HomeModel *)item atIndex:(NSInteger)index inViewController:(BaseViewController *)parentViewController;


@end
