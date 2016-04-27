//
//  MLBTapImageView.h
//  OneDay
//
//  Created by 卢良潇 on 16/4/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapAction)(id obj);

@interface MLBTapImageView : UIImageView

- (void)addTapBlock:(TapAction)tapAction;

- (void)setImageWithURL:(NSString *)imgURL placeholderImageName:(NSString *)placeholderImageName tapBlock:(TapAction)tapAction;

@end
