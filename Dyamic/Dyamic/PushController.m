//
//  PushController.m
//  Dyamic
//
//  Created by 刘志远 on 16/5/12.
//  Copyright © 2016年 刘志远. All rights reserved.
//

#import "PushController.h"
#define RANDOM_COLOR [UIColor colorWithRed:arc4random() % 256 / 255.f green:arc4random() % 256 / 255.f blue:arc4random() % 256 / 255.f alpha:1.f]; //随机色

@interface PushController ()<UICollisionBehaviorDelegate>
@property(nonatomic,strong) UIView *bigView;
@property(nonatomic,strong) UIView *smallView;
@property(nonatomic,strong) UIView *longView;
//力学行为
@property(nonatomic,strong) UIDynamicAnimator *animator;
@property(nonatomic,strong) UIAttachmentBehavior *attachment;/**<吸附对象 */
@property(nonatomic,strong) UIGravityBehavior *gravity; /**<重力对象 */
@property(nonatomic,strong) UICollisionBehavior *collision; /**<碰撞对象 */


@end

@implementation PushController{
    BOOL first;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _bigView = [[UIView alloc]initWithFrame:CGRectMake(50, 100, 100, 100)];
    _bigView.backgroundColor = RANDOM_COLOR
    [self.view addSubview:_bigView];
    
    _smallView = [[UIView alloc]initWithFrame:CGRectMake(130, 300, 10, 10)];
    _smallView.backgroundColor = RANDOM_COLOR;
    [self.view addSubview:_smallView];
    
    _longView = [[UIView alloc]initWithFrame:CGRectMake(0, 350, 120, 5)];
    _longView.backgroundColor = RANDOM_COLOR;
    [self.view addSubview:_longView];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    //重力行为
    _gravity = [[UIGravityBehavior alloc]initWithItems:@[_bigView]];
    [_animator addBehavior:_gravity];
    //碰撞行为
    _collision = [[UICollisionBehavior alloc]initWithItems:@[_bigView]];
    //添加一个边界
    [_collision addBoundaryWithIdentifier:@"barrier" fromPoint:_longView.frame.origin toPoint:CGPointMake(_longView.frame.origin.x + _longView.frame.size.width, _longView.frame.origin.y + _longView.frame.size.height)];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    _collision.collisionDelegate = self;
    [_animator addBehavior:_collision];
    //添加限制
    UIDynamicItemBehavior *itembehaviour = [[UIDynamicItemBehavior alloc]initWithItems:@[_bigView]];
    itembehaviour.elasticity = 0.5;
    [_animator addBehavior:itembehaviour];
    
    
}
- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier atPoint:(CGPoint)p{
    if (!first) {
        first = YES;
        //设置吸附
        _attachment = [[UIAttachmentBehavior alloc]initWithItem:_smallView attachedToItem:_bigView];
        [_animator addBehavior:_attachment];
        //设置推行为
        UIPushBehavior *push = [[UIPushBehavior alloc]initWithItems:@[_bigView] mode:UIPushBehaviorModeInstantaneous];
        CGVector
        pushdirection = {0.5,-0.5};
        [push setPushDirection:pushdirection];
        //设置力度
        [push setMagnitude:5.0f];
        [_animator addBehavior:push];
    }
    
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
