//
//  ViewController.m
//  用CALayer实现淡入淡出的切换图片效果
//
//  Created by RinpeChen on 16/1/20.
//  Copyright © 2016年 miaoqu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) CALayer *imageLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化图层上的图片内容
    UIImage *start = [UIImage imageNamed:@"开始图片"];
    self.imageLayer = [CALayer layer];
    self.imageLayer.frame = CGRectMake(0, 0, 872 / 3, 1634 / 3);
    self.imageLayer.contents = (id)start.CGImage;
    [self.view.layer addSublayer:self.imageLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self changeBg];
}

- (void)changeBg
{
    UIImage *end = [UIImage imageNamed:@"结束图片"];
    // 隐式动画
    // self.imageLayer.contents = (id)end.CGImage;
    
    /* 显式动画 */
    
    // 图片切换动画
    CABasicAnimation *imageChangeAniamtion = [CABasicAnimation animationWithKeyPath:@"contents"];
    imageChangeAniamtion.fromValue = self.imageLayer.contents;
    imageChangeAniamtion.toValue = (id)end.CGImage;
//    imageChangeAniamtion.duration = 3.f;
    
    // 图片缩放动画
    CABasicAnimation *boundsChangeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsChangeAnimation.fromValue = [NSValue valueWithCGRect:self.imageLayer.bounds];
    boundsChangeAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 302 * 0.5, 707 * 0.5)];
//    boundsChangeAnimation.duration = 3.f;
    
    // 组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[imageChangeAniamtion, boundsChangeAnimation];
    // 设置了组合动画之后, 动画的持续时间在组合动画里设置, 否则将没办法完全显示所有动画
    animationGroup.duration = 1.f;
    
    // 注意: 显式动画只是一个过程,并没有真正意义的的修改图层的内容, 需要进行手动修改
    // 否则动画完毕之后会恢复到原来的样式
    self.imageLayer.contents = (id)end.CGImage;
    self.imageLayer.bounds = CGRectMake(0, 0, 302 * 0.5, 707 * 0.5);
    
    [self.imageLayer addAnimation:animationGroup forKey:nil];
}

@end
