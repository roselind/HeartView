//
//  HomeViewController.m
//  OneDay
//
//  Created by 卢良潇 on 16/4/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import "HomeViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface HomeViewController () <GMCPagingScrollViewDataSource,GMCPagingScrollViewDelegate,CLLocationManagerDelegate>{
    
    AAPullToRefresh *pullToRefreshLeft;
    AAPullToRefresh *pullToRefreshRight;
    HomeView *homeview;
}

@property (strong, nonatomic) GMCPagingScrollView *pagingScrollView;
@property (strong, nonatomic) UIButton *diaryButton;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UILabel *likeNumLabel;
@property (assign, nonatomic) NSUInteger likeNum;
@property (strong, nonatomic) UIButton *moreButton;
//数据源
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation HomeViewController



- (void)dealloc
{
    pullToRefreshLeft.showPullToRefresh = NO;
    pullToRefreshRight.showPullToRefresh = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupView];
    [self setButtons];
    [self loadCache];
    [self requestHomeMore];
  
        // Do any additional setup after loading the view.
}

//设置主视图
- (void)setupView
{
    //设置标题
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_home_title"]];
    self.navigationItem.titleView = titleView;
    
    //添加scrollview
    __weak typeof (self) weakSelf = self;
    _pagingScrollView = ({
        GMCPagingScrollView *pagingScrollView = [GMCPagingScrollView new];
        pagingScrollView.backgroundColor = MLBViewControllerBGColor;
        [pagingScrollView registerClass:[HomeView class] forReuseIdentifier:HomeViewID];
        pagingScrollView.dataSource = self;
        pagingScrollView.delegate = self;
        pagingScrollView.pageInsets = UIEdgeInsetsZero;
        pagingScrollView.interpageSpacing = 0;
        pullToRefreshLeft = [pagingScrollView.scrollView addPullToRefreshPosition:AAPullToRefreshPositionLeft actionHandler:^(AAPullToRefresh *v) {
            [weakSelf refreshHomeMore];
            [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1];
        }];
        
        
        pullToRefreshLeft.threshold = 100;
        pullToRefreshLeft.borderColor = MLBAppThemeColor;
        pullToRefreshLeft.borderWidth = MLBPullToRefreshBorderWidth;
        pullToRefreshLeft.imageIcon = [UIImage new];
        
        pullToRefreshRight = [pagingScrollView.scrollView addPullToRefreshPosition:AAPullToRefreshPositionRight actionHandler:^(AAPullToRefresh *v) {
            [weakSelf showPreviousList];
            [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1];
        }];
        pullToRefreshRight.borderColor = MLBAppThemeColor;
        pullToRefreshRight.borderWidth = MLBPullToRefreshBorderWidth;
        pullToRefreshRight.imageIcon = [UIImage new];
        
        [self.view addSubview:pagingScrollView];
        [pagingScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        pagingScrollView.hidden = YES;
        
        pagingScrollView;
    });
    
    
    
}

//设置按钮
- (void)setButtons
{

    
    _diaryButton = ({
        UIButton *button = [MLBUIFactory buttonWithImageName:@"diary_normal" highlightImageName:nil target:self action:@selector(diaryButtonClicked)];
        [_pagingScrollView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(66, 44));
            make.left.equalTo(_pagingScrollView).offset(8);
            make.bottom.equalTo(_pagingScrollView).offset(-73);
        }];
        
        button;
    });
    
    _moreButton = ({
        UIButton *button = [MLBUIFactory buttonWithImageName:@"share_image" highlightImageName:nil target:self action:@selector(moreButtonClicked)];
        [_pagingScrollView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@44);
            make.right.equalTo(_pagingScrollView).offset(-8);
            make.bottom.equalTo(_diaryButton);
        }];
        
        button;
    });
    
    _likeNumLabel = ({
        UILabel *label = [UILabel new];
        label.textColor = MLBDarkGrayTextColor;
        label.font = FontWithSize(11);
        [_pagingScrollView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@44);
            make.right.equalTo(_moreButton.mas_left);
            make.bottom.equalTo(_diaryButton);
        }];
        
        label;
    });
    
    _likeButton = ({
        UIButton *button = [MLBUIFactory buttonWithImageName:@"like_normal" selectedImageName:@"like_selected" target:self action:@selector(likeButtonClicked)];
        [_pagingScrollView addSubview:button];
        button.selected = NO;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@44);
            make.right.equalTo(_likeNumLabel.mas_left);
            make.bottom.equalTo(_diaryButton);
        }];
        
        button;
    });
    

}

/**
 *  加载缓存
 */
- (void)loadCache
{
    id cacheItems = [NSKeyedUnarchiver unarchiveObjectWithFile:MLBCacheHomeItemFilePath];
    if (cacheItems) {
        self.dataSource = cacheItems;
    }

}

# pragma mark - datasource


- (HomeModel *)homeItemAtIndex:(NSInteger)index {
    return _dataSource[index];
}

- (void)updateLikeNumLabelTextWithItemIndex:(NSInteger)index {
 
    _likeNum = [self homeItemAtIndex:index].praiseNum;
    _likeNumLabel.text = [@(_likeNum) stringValue];
}


- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    _pagingScrollView.hidden = NO;
    [_pagingScrollView reloadData];
    // 防止加载出来前用户滑动而跳转到了最后一个
    [_pagingScrollView setCurrentPageIndex:0];
    if (dataSource.count > 0) {
        [self updateLikeNumLabelTextWithItemIndex:0];
    }
    
}


#pragma mark - 点击方法

- (void)refreshHomeMore {
  
    [_pagingScrollView setCurrentPageIndex:0 reloadData:NO];
    // 刷新
    [self refreshHomeMore];
}

- (void)showPreviousList {
    // 原因同上
    [_pagingScrollView setCurrentPageIndex:(_dataSource.count - 1) reloadData:NO];
    // 显示往期列表
//    MLBPreviousViewController *previousViewController = [[MLBPreviousViewController alloc] init];
//    previousViewController.previousType = MLBPreviousTypeHome;
//    [self.navigationController pushViewController:previousViewController animated:YES];
}

- (void)diaryButtonClicked {
     NSLog(@"点击");
 //   [self presentLoginOptsViewController];
}

- (void)likeButtonClicked {
    
    if (_likeButton.selected) {
        _likeButton.selected = NO;
        _likeNum -= 1;
    }
    else
    {
        _likeNum += 1;
        _likeButton.selected = YES;
    }
    
    _likeNumLabel.text = [@(_likeNum) stringValue];
 
    
}

- (void)moreButtonClicked {
    NSLog(@"点击");
    [self showPopMenuViewWithMenuSelectedBlock:^(MenuType menuType) {
        DDLogDebug(@"menuType = %ld", menuType);
    }];
}
    
# pragma mark - 网络请求
    

- (void)requestHomeMore {
    
    [MLBHTTPRequester requestHomeMoreWithSuccess:^(id responseObject) {
        if ([responseObject[@"res"] integerValue] == 0) {
            NSError *error;
            NSArray *items = [MTLJSONAdapter modelsOfClass:[HomeModel class] fromJSONArray:responseObject[@"data"] error:&error];
            if (!error) {
                self.dataSource = items;
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [NSKeyedArchiver archiveRootObject:_dataSource toFile:MLBCacheHomeItemFilePath];
                });
            } else {
                NSLog(@"%@",error);
            }
        } else {
      
        }
    } fail:^(NSError *error) {
           NSLog(@"%@",error);
    }];
        
    }

#pragma mark - GMCPagingScrollViewDataSource

- (NSUInteger)numberOfPagesInPagingScrollView:(GMCPagingScrollView *)pagingScrollView {
    return _dataSource.count;
}

- (UIView *)pagingScrollView:(GMCPagingScrollView *)pagingScrollView pageForIndex:(NSUInteger)index {
    
    HomeView *view = [pagingScrollView dequeueReusablePageWithIdentifier:HomeViewID];
    
   [view setViewWithHomeItems:[self homeItemAtIndex:index] atIndex:index];
    
    return view;
}


#pragma mark - GMCPagingScrollViewDelegate

- (void)pagingScrollViewDidScroll:(GMCPagingScrollView *)pagingScrollView {
    if (_pagingScrollView.isDragging) {
        CGPoint contentOffset = pagingScrollView.scrollView.contentOffset;
        pagingScrollView.scrollView.contentOffset = CGPointMake(contentOffset.x, 0);
    }
}

- (void)pagingScrollView:(GMCPagingScrollView *)pagingScrollView didScrollToPageAtIndex:(NSUInteger)index {
    [self updateLikeNumLabelTextWithItemIndex:index];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    DDLogDebug(@"locations = %@", locations);
    
}








@end
