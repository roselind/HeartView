//
//  ViewController.m
//  CoreTextDemo
//
//  Created by 卢良潇 on 16/4/25.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import "ViewController.h"
#import "CTFrameParser.h"
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"
#import "CTDisplayView.h"
#import "UIView+frameAdjust.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet CTDisplayView *ctView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc]init];
    config.textColor = [UIColor redColor];
    config.width = self.ctView.width;
    
    
    
    NSString *content = @"dfb sdouvbnwroivnwroivneroivneriovneriovneornvernveaoivnesoivnesoivnesoinveionveoinveorinveroivneroinverionvrieonvoirnvoiernvoiernviore";
    NSDictionary *attr = [CTFrameParser attributesWithConfig:config];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content attributes:attr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 7)];
    CoreTextData *data = [CTFrameParser parseContent:@"我来试试11111111111111111111111111" config:config];
    
    
    
    self.ctView.data = data;
    self.ctView.height = data.height;
    self.ctView.backgroundColor = [UIColor yellowColor];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
