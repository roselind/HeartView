//
//  NavigationController.m
//  OneDay
//
//  Created by 卢良潇 on 16/4/26.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController () <UIGestureRecognizerDelegate>

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景颜色
    [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
    //返回键颜色
    [UINavigationBar appearance].barStyle = UIBarStyleDefault;
    [UINavigationBar appearance].tintColor = [UIColor blackColor];
    NSDictionary *navTitleAttr = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    [UINavigationBar appearance].titleTextAttributes = navTitleAttr;

   
    
    
    // Do any additional setup after loading the view.
}




- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed:@"button_back_white"] style: UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    
    [super pushViewController:viewController animated:YES];
}



- (void)back
{
    [self popViewControllerAnimated:YES];

}


- (void)setGesture
{

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
    

}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count != 1;
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
