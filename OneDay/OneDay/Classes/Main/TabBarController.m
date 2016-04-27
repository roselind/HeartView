//
//  TabBarController.m
//  OneDay
//
//  Created by 卢良潇 on 16/4/26.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    [UITabBar appearance].tintColor = [UIColor blackColor];
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    [self setTabBar];
    
    
    // Do any additional setup after loading the view.
}


- (void)setTabBar
{
    NSArray *imageArray = @[@"tab_home", @"tab_read", @"tab_music", @"tab_movie"];
    NSArray *nameArray = @[@"首页",@"阅读",@"音乐",@"电影"];
    NSInteger index = 0;
    
    for (UIViewController *vc in self.viewControllers) {
        NSString *normalImageName =  [NSString stringWithFormat:@"%@_normal", [imageArray objectAtIndex:index]];
        NSString *selectedImageName = [NSString stringWithFormat:@"%@_selected", [imageArray objectAtIndex:index]];
        NSString *titleName = [nameArray objectAtIndex:index];
        UIImage *normalImage = [UIImage imageNamed:normalImageName];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        
        vc.title = titleName;
        vc.tabBarItem.image = normalImage;
        vc.tabBarItem.selectedImage = selectedImage;
        
        index++;
    }


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
