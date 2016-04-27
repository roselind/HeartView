//
//  DataSource.h
//  lightTest
//
//  Created by 卢良潇 on 16/4/25.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);


@interface DataSource : NSObject <UITableViewDataSource>


- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
