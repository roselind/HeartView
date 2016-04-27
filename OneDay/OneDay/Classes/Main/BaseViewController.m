//
//  BaseViewController.m
//  OneDay
//
//  Created by 卢良潇 on 16/4/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_search"] style:UIBarButtonItemStylePlain target:self action:@selector(pushToSearch)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_me_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(pushToMe)];
    self.view.backgroundColor = ViewControllerBGColor;
    // 设置标题栏不能覆盖下面 ViewController 的内容
    self.edgesForExtendedLayout = UIRectEdgeNone;

    // Do any additional setup after loading the view.
}



- (void)pushToMe
{
    
    
}

- (void)pushToSearch
{
    
    
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
