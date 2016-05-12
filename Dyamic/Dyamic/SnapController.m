//
//  SnapController.m
//  Dyamic
//
//  Created by 刘志远 on 16/5/12.
//  Copyright © 2016年 刘志远. All rights reserved.
//

#import "SnapController.h"
#define RANDOM_COLOR [UIColor colorWithRed:arc4random() % 256 / 255.f green:arc4random() % 256 / 255.f blue:arc4random() % 256 / 255.f alpha:1.f]; //随机色

@interface SnapController ()
@property(nonatomic,strong) UIView *bigView;
@property(nonatomic,strong) UIDynamicAnimator *animator;
@property(nonatomic,strong) UISnapBehavior *snap;
@end

@implementation SnapController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor  = [UIColor whiteColor];
    _bigView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 80, 80)];
    _bigView.backgroundColor = RANDOM_COLOR;
    _bigView.layer.cornerRadius = 40;
    [self.view addSubview:_bigView];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    
}
- (void)tap:(UITapGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:self.view];
    //移除甩行为
    [_animator removeBehavior:_snap];
    _snap = [[UISnapBehavior alloc]initWithItem:_bigView snapToPoint:point];
    [_animator addBehavior:_snap];
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
