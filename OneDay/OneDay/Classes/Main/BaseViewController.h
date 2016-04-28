//
//  BaseViewController.h
//  OneDay
//
//  Created by 卢良潇 on 16/4/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, MenuType) {
    MenuTypeWechatFrined,// 微信好友
    MenuTypeMoments,// 朋友圈
    MenuTypeWeibo,// 微博
    MenuTypeQQ,// QQ
    MenuTypeCopyURL,// 复制链接
    MenuTypeFavorite,// 收藏
};

typedef void(^MenuSelectedBlock)(MenuType menuType);


@interface BaseViewController : UIViewController


- (void)blowUpImage:(UIImage *)image referenceRect:(CGRect)referenceRect referenceView:(UIView *)referenceView;

- (void)showPopMenuViewWithMenuSelectedBlock:(MenuSelectedBlock)block;
@end
