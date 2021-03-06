//
//  MLBTapImageView.m
//  OneDay
//
//  Created by 卢良潇 on 16/4/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import "MLBTapImageView.h"

@interface MLBTapImageView ()

@property (copy, nonatomic) TapAction tapAction;

@end

@implementation MLBTapImageView

- (void)dealloc {
    DDLogDebug(@"%@ - %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)tap {
    if (self.tapAction) {
        self.tapAction(self);
    }
}

- (void)addTapBlock:(TapAction)tapAction {
    self.tapAction = tapAction;
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
}

- (void)setImageWithURL:(NSString *)imgURL placeholderImageName:(NSString *)placeholderImageName tapBlock:(TapAction)tapAction {
    [self mlb_sd_setImageWithURL:imgURL placeholderImageName:placeholderImageName];
    [self addTapBlock:tapAction];
}

@end
