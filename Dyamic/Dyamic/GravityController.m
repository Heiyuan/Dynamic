//
//  GravityController.m
//  Dyamic
//
//  Created by 刘志远 on 16/5/11.
//  Copyright © 2016年 刘志远. All rights reserved.
//

#import "GravityController.h"
#import <AVFoundation/AVFoundation.h>

@interface GravityController ()<UICollisionBehaviorDelegate>
@property(nonatomic,strong) UIView *animaView;
@property(nonatomic,strong) UIDynamicAnimator *animator;
@property(nonatomic,strong) UIGravityBehavior *gravity;
@property(nonatomic,strong) UICollisionBehavior *collision;
@property (nonatomic, strong) AVAudioPlayer *player;
@property(nonatomic,strong) NSURL *pingurl;
@end

@implementation GravityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _animaView = [[UIView alloc]initWithFrame:CGRectMake(50, 70, 50,50)];
//    _animaView.layer.cornerRadius = 25;
    _animaView.tag = 998;
    [self.view addSubview:_animaView];
    _animaView.backgroundColor = [UIColor redColor];
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    //重力行为
    _gravity = [[UIGravityBehavior alloc]initWithItems:@[_animaView]];
    CGVector gravityDirection = {0.0,0.2};
    [_gravity setGravityDirection:gravityDirection];
    [_animator addBehavior:_gravity];
    //碰撞行为
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(60, 200, 200, 10)];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    _collision = [[UICollisionBehavior alloc]initWithItems:@[_animaView,view]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];
    _collision.collisionDelegate = self;
    //增加属性
    UIDynamicItemBehavior *itembehaviour = [[UIDynamicItemBehavior alloc]initWithItems:@[_animaView,view]];
    //弹力系数
    [itembehaviour setElasticity:1];
    //旋转角阻力
    [itembehaviour setAngularResistance:0];
    //密度
    [itembehaviour setDensity:10];
    //摩擦系数
    [itembehaviour setFriction:0];
    //阻力
    [itembehaviour setResistance:0];
    //是否允许旋转
    itembehaviour.allowsRotation = YES;
    [_animator addBehavior:itembehaviour];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ping" ofType:@"mp3"];
    _pingurl = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:_pingurl error:&error];
    _player.volume = 0.2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//视图碰撞时触发
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id <UIDynamicItem>)item1 withItem:(id <UIDynamicItem>)item2 atPoint:(CGPoint)p{
    NSLog(@"%@%@",item1,item2);
    NSLog(@"%@",NSStringFromCGPoint(p));
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_player play];
        
    });

}
//视图碰撞结束
//- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id <UIDynamicItem>)item1 withItem:(id <UIDynamicItem>)item2;
//
//视图碰到边界属性
- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier atPoint:(CGPoint)p{
     NSLog(@"%@",NSStringFromCGPoint(p));
 

    

}
//- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier;
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
