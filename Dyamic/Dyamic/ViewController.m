//
//  ViewController.m
//  Dyamic
//
//  Created by 刘志远 on 16/5/11.
//  Copyright © 2016年 刘志远. All rights reserved.
//

#import "ViewController.h"
#import "taotaocell.h"
#define RANDOM_COLOR [UIColor colorWithRed:arc4random() % 256 / 255.f green:arc4random() % 256 / 255.f blue:arc4random() % 256 / 255.f alpha:1.f]; //随机色

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *titleArr;
@property(nonatomic,strong) NSArray *ClassArr;
@end

@implementation ViewController
- (void)loadView{
    [super loadView];
    _titleArr = @[@"重力碰撞",@"吸附",@"甩",@"推"];
    _ClassArr = @[@"GravityController",@"AdsorbController",@"SnapController",@"PushController"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Dyamic";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    taotaocell *cell = [tableView dequeueReusableCellWithIdentifier:@"taotao"];
    cell.contentView.backgroundColor = RANDOM_COLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title.text = _titleArr[indexPath.row];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = _ClassArr[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *controller = [[class alloc] init];
        controller.title = _titleArr[indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
