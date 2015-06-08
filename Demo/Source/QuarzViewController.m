//
//  DemoSnippetsViewController.m
//  DTCoreText
//
//  Created by Sam Soffes on 1/14/11.
//  Copyright 2011 Drobnik.com. All rights reserved.
//

#import "QuarzViewController.h"
#import "CoreTextView.h"

@implementation QuarzViewController

#pragma mark NSObject

- (id)init
{
	self = [super init];
	
	if (self)
	{
		
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	CGRect frame = CGRectMake(0, 100, 320, 444);
	UIImage *image = [UIImage imageNamed:@"peticon0004.png"];
	UIImageView *animatedView = [[UIImageView alloc] initWithImage:image];
	animatedView.frame = frame;
//	[self.view addSubview:animatedView];

	
	self.view.backgroundColor = [UIColor whiteColor];
	
	
	CoreTextView *t = [[CoreTextView alloc] initWithFrame:frame];
	[self.view addSubview:t];
//
//	CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//	CATransform3D transform3d1 = CATransform3DMakeRotation(M_PI * 0.0, 0, 0, 1.0f);
//	CATransform3D transform3d2 = CATransform3DMakeRotation(M_PI * 0.5, 0, 0, 1.0f);
//	CATransform3D transform3d3 = CATransform3DMakeRotation(M_PI * 1.0, 0, 0, 1.0f);
//	CATransform3D transform3d4 = CATransform3DMakeRotation(M_PI * 1.5, 0, 0, 1.0f);
//	CATransform3D transform3d5 = CATransform3DMakeRotation(M_PI * 2.0, 0, 0, 1.0f);
//	NSValue *value1 = [NSValue valueWithCATransform3D:transform3d1];
//	NSValue *value2 = [NSValue valueWithCATransform3D:transform3d2];
//	NSValue *value3 = [NSValue valueWithCATransform3D:transform3d3];
//	NSValue *value4 = [NSValue valueWithCATransform3D:transform3d4];
//	NSValue *value5 = [NSValue valueWithCATransform3D:transform3d5];
//	keyFrame.values = @[value1, value2, value3, value4, value5];
//	keyFrame.duration = 20;
//	keyFrame.repeatCount = 100000;
//	[imageview.layer addAnimation:keyFrame forKey:nil];
	
//	// 声明一个动画
//	CATransition *animation = [CATransition animation];
//	// 设置动画时间
//	animation.duration = 11111.0f;
//	// 设置动画动画的执行效果 慢--快--慢的效果
//	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//	// 设置动画的样式
//	// animation.type = kCATransitionMoveIn;
//	animation.type = @"cube"; // 私有API中的立方体滚动
//	// 设置动画的移入的位置 从左、从右、从上、从下
//	// animation.subtype = kCATransitionFromTop;
//	animation.subtype = @"toLeft"; // 私有API中的从左面滚动
//	// 给animatedView添加动画
//	[imageview.layer addAnimation:animation forKey:nil];
	
//	CGAffineTransform transform2 = CGAffineTransformRotate(animatedView.transform, M_PI_4);
//	
//	// 缩小，放大
//	CGAffineTransform transform4 = CGAffineTransformScale(animatedView.transform, 0.9f, 0.9f); // 可以连续操作
//	// 移动
//	CGAffineTransform transform6 = CGAffineTransformTranslate(animatedView.transform, 0, -120);
//	
//	[UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:0.5f];
//	[animatedView setTransform:transform4];
//	[UIView commitAnimations];

	
//	CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
//	CATransform3D transform3d1 = CATransform3DMakeTranslation(10, 10, 10); // 3D移动效果
//	CATransform3D transform3d11 = CATransform3DTranslate(transform3d1, 10, 10, 10);
//	CATransform3D transform3d2 = CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0); // 3D旋转效果
//	CATransform3D transform3d22 = CATransform3DRotate(transform3d2, M_PI, 0.0, 0.0, 1.0);
//	CATransform3D transform3d3 = CATransform3DMakeScale(0.2f, 1.2f, 1.2f); // 3D缩放效果
//	CATransform3D transform3d33 = CATransform3DTranslate(transform3d2, 0.0, 0.0, 0.0);
//	basicAnimation.toValue = [NSValue valueWithCATransform3D:transform3d1];
//	basicAnimation.removedOnCompletion = YES; // 动画结束后去除动画
//	basicAnimation.duration = 0.5f; // 设置动画时间
//	basicAnimation.cumulative = NO;
//	basicAnimation.repeatCount = 0; // 循环次数
//	[animatedView.layer addAnimation:basicAnimation forKey:nil];

	
}


@end
