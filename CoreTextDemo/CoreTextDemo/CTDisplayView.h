//
//  CTDisplayView.h
//  CoreTextDemo
//
//  Created by 卢良潇 on 16/4/25.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+frameAdjust.h"
#import "CoreTextData.h"

@interface CTDisplayView : UIView

@property (nonatomic,strong) CoreTextData *data;
@end
