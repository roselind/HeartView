//
//  HomeView.m
//  OneDay
//
//  Created by 卢良潇 on 16/4/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import "HomeView.h"
#import "HomeModel.h"
#import "BaseViewController.h"

NSString *const HomeViewID = @"HomeViewID";


@interface HomeView ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIButton *diaryButton;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UILabel *likeNumLabel;
@property (strong, nonatomic) UIButton *moreButton;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIImageView *coverView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *weatherView;
@property (strong, nonatomic) UILabel *temperatureLabel;
@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UITextView *contentTextView;
@property (strong, nonatomic) UILabel *volLabel;

@property (strong, nonatomic) MASConstraint *textViewHeightConstraint;

@end



@implementation HomeView


#pragma mark - init方法

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}



# pragma mark - 设置视图

- (void)setupViews {
    if (_scrollView) {
        return;
    }
    
    
    self.backgroundColor = [UIColor clearColor];
    
    _scrollView = ({
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        scrollView;
    });

    
    _contentView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.shadowColor = MLBShadowColor.CGColor;// #666666
        view.layer.shadowRadius = 2;
        view.layer.shadowOffset = CGSizeZero;
        view.layer.shadowOpacity = 0.5;
        view.layer.cornerRadius = 5;
        [_scrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_scrollView).insets(UIEdgeInsetsMake(76, 12, 184, 12));
            make.width.equalTo(@(SCREEN_WIDTH - 24));
        }];
        
        view;
    });
    
    _coverView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverTapped)];
        [imageView addGestureRecognizer:tap];
        [_contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(_contentView).insets(UIEdgeInsetsMake(6, 6, 0, 6));
            make.height.equalTo(imageView.mas_width).multipliedBy(0.75);
        }];
        
        imageView;
    });
    
    _volLabel = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = MLBLightGrayTextColor;
        label.font = FontWithSize(11);
        [_contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_coverView.mas_bottom).offset(10);
            make.left.equalTo(_coverView);
        }];
        
        label;
    });
    
    _titleLabel = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = MLBGrayTextColor;
        label.font = FontWithSize(10);
        label.textAlignment = NSTextAlignmentRight;
        [label setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal];
        [_contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_coverView.mas_bottom).offset(8);
            make.left.greaterThanOrEqualTo(_volLabel.mas_right).offset(4);
            make.right.equalTo(_coverView);
        }];
        
        label;
    });
    
    _contentTextView = ({
        UITextView *textView = [UITextView new];
        textView.backgroundColor = [UIColor whiteColor];
        textView.textColor = MLBLightBlackTextColor;
        textView.font = FontWithSize(14);
        textView.editable = NO;
        [_contentView addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_volLabel.mas_bottom).offset(15);
            make.left.right.equalTo(_coverView);
            _textViewHeightConstraint = make.height.equalTo(@0);
        }];
        
        textView;
    });
    
    _dateLabel = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = MLBDarkGrayTextColor;
        label.font = FontWithSize(12);
        [_contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentTextView.mas_bottom).offset(10);
            make.right.equalTo(_coverView);
            make.bottom.equalTo(_contentView).offset(-12);
        }];
        
        label;
    });
    
    _locationLabel = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = MLBDarkGrayTextColor;
        label.font = FontWithSize(12);
        [_contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_dateLabel);
            make.right.equalTo(_dateLabel.mas_left).offset(-10);
        }];
        
        label;
    });
    
    _temperatureLabel = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = MLBDarkGrayTextColor;
        label.font = FontWithSize(12);
        [_contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_dateLabel);
            make.right.equalTo(_locationLabel.mas_left).offset(-2);
        }];
        
        label;
    });
    
    _weatherView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@24);
            make.centerY.equalTo(_dateLabel);
            make.right.equalTo(_temperatureLabel.mas_left).offset(-5);
        }];
        
        imageView;
    });
}


#pragma mark - 点击方法

//图片弹出
- (void)coverTapped {
 
    if (self.parentViewController) {
        [self.parentViewController blowUpImage:_coverView.image referenceRect:_coverView.frame referenceView:_coverView.superview];
    }

    
}

#pragma mark - 设置数据方法

- (void)setViewWithHomeItems:(HomeModel *)item atIndex:(NSInteger)index
{
    [self setViewWithHomeItem:item atIndex:index inViewController:nil];

}


- (void)setViewWithHomeItem:(HomeModel *)item atIndex:(NSInteger)index inViewController:(BaseViewController *)parentViewController {

    self.viewIndex = index;
    self.parentViewController = parentViewController;
    [_coverView mlb_sd_setImageWithURL:item.imageURL placeholderImageName:@"home_cover_placeholder"];
    _titleLabel.text = item.authorName;
    _weatherView.image = [UIImage imageNamed:@"light_rain"];
    _temperatureLabel.text = @"6℃";
    _locationLabel.text = @"杭州";
    _dateLabel.text = [MLBUtilities stringDateFormatWithddMMMyyyyEEEByNormalDateString:item.makeTime];
    
    _contentTextView.attributedText = [MLBUtilities mlb_attributedStringWithText:item.content lineSpacing:10 font:_contentTextView.font textColor:_contentTextView.textColor];

    _textViewHeightConstraint.equalTo(@(ceilf([MLBUtilities mlb_rectWithAttributedString:_contentTextView.attributedText size:CGSizeMake((SCREEN_WIDTH - 24 - 12), CGFLOAT_MAX)].size.height) + 50));
    
    _volLabel.text = item.title;
    _scrollView.contentOffset = CGPointZero;
    
    
    // 如果是-1，说明是单个视图界面，则显示按钮上的图片和点赞数
    if (index == -1) {
        [_diaryButton setImage:[UIImage imageNamed:@"diary_normal"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"share_image"] forState:UIControlStateNormal];
        [_likeButton setImage:[UIImage imageNamed:@"like_normal"] forState:UIControlStateNormal];
        [_likeButton setImage:[UIImage imageNamed:@"like_selected"] forState:UIControlStateSelected];
        
        _likeNumLabel.text = [@(item.praiseNum) stringValue];
    }
}



@end
