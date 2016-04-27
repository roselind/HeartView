//
//  ViewController.m
//  lightTest
//
//  Created by 卢良潇 on 16/4/25.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

#import "ViewController.h"
#import "DataSource.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) DataSource *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    TableViewCellConfigureBlock confi = ^(UITableViewCell *cell, id item)
    {
        cell.textLabel.text = item;
    
    };
    
    
    _array = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
   
    _tableview.delegate = self;
    
    self.dataSource = [[DataSource alloc] initWithItems:_array cellIdentifier:@"Cell" configureCellBlock:confi];
    _tableview.dataSource = self.dataSource;
 //   _tableview.dataSource =
    // Do any additional setup after loading the view, typically from a nib.
}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return _array.count;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.textLabel.text = _array[indexPath.row];
//    return cell;
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
