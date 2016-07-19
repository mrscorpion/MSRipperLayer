//
//  MSRipperView.m
//  MSRippleLayer
//
//  Created by mr.scorpion on 16/7/19.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSRipperView.h"
const CGFloat MSFlashInnerCircleInitialRadius = 20;

@implementation MSRipperView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //
        [self commonInit];
    }
    return self;
}
- (void) commonInit {
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self addGestureRecognizer:tap];
    
    self.textlabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.textlabel.backgroundColor = [UIColor clearColor];
    [self.textlabel setTextColor:[UIColor whiteColor]];
    [self.textlabel setTextAlignment: NSTextAlignmentCenter];
    [self addSubview:self.textlabel];
    
    self.backgroundColor = [UIColor grayColor];
    self.buttonType = MSFlashbuttonTypeInner;
}

#pragma mark - PUBLIC -
- (void)setText:(NSString *)text {
    [self setText:text withTextColor:nil];
}
- (void)setTextColor:(UIColor *)textColor {
    [self setText:nil withTextColor:textColor];
}
- (void)setText:(NSString *)text withTextColor:(UIColor *)textColor {
    if (text) {
        [self.textlabel setText:text];
    }
    if (textColor) {
        [self.textlabel setTextColor:textColor];
    }
}

- (void)setButtonType:(MSFlashbuttonType)buttonType {
    if (buttonType == MSFlashbuttonTypeInner) {
        self.clipsToBounds = YES;
    }else {
        self.clipsToBounds = NO;
    }
    _buttonType = buttonType;
}

#pragma mark - PRIVATE -
- (void)tapClick:(UITapGestureRecognizer *)tapGestureHandler {
    CGPoint taplocation = [tapGestureHandler locationInView:self];
    CAShapeLayer * circleShape = nil;
    CGFloat scale = 1.0f;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    if (self.buttonType == MSFlashbuttonTypeInner) {
        CGFloat biggerEdge = width > height ? width : height;
        CGFloat smallerEdge = width > height ? height : width;
        CGFloat radius = smallerEdge / 2 > MSFlashInnerCircleInitialRadius ? MSFlashInnerCircleInitialRadius : smallerEdge / 2;
        scale = biggerEdge / radius + 0.5;
        circleShape = [self createCircleShapeWithPosition:CGPointMake(taplocation.x - radius, taplocation.y - radius) pathRect:CGRectMake(0, 0, radius * 2, radius * 2) radius:radius];
    }else {
        scale = 2.5f;
        circleShape = [self createCircleShapeWithPosition:CGPointMake(width/2, height/2) pathRect:CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), width, height) radius:self.layer.cornerRadius];
    }
    [self.layer addSublayer:circleShape];
    CAAnimationGroup * groupAnimation = [self createFlashAnimationWithScale:scale duration:0.5f];
    [groupAnimation setValue:circleShape forKey:@"circleShaperLayer"];
    [circleShape addAnimation:groupAnimation forKey:nil];
    [circleShape setDelegate:self];
}

- (CAShapeLayer *)createCircleShapeWithPosition:(CGPoint)position pathRect:(CGRect)rect radius:(CGFloat)radius {
    CAShapeLayer * circleShape = [CAShapeLayer layer];
    circleShape.path = [self createCirclePathWithRect:rect radius:radius];
    circleShape.position = position;
    if (self.buttonType == MSFlashbuttonTypeInner) {
        circleShape.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
        circleShape.fillColor = self.flashColor ? self.flashColor.CGColor : [UIColor whiteColor].CGColor;
    }else {
        circleShape.fillColor = [UIColor clearColor].CGColor;
        circleShape.strokeColor = self.flashColor ? self.flashColor.CGColor : [UIColor purpleColor].CGColor;
    }
    circleShape.opacity = 0;
    circleShape.lineWidth = 1.0f;
    
    return circleShape;
}

- (CAAnimationGroup *)createFlashAnimationWithScale:(CGFloat)scale duration:(CGFloat)duration {
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1)];
    
    CABasicAnimation * alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup * animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation,alphaAnimation];
    animation.delegate = self;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return animation;
}

- (CGPathRef)createCirclePathWithRect:(CGRect)frame radius:(CGFloat)radius {
    return [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius].CGPath;
}
#pragma mark - CAAnimationDelegate -
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CALayer * layer = [anim valueForKey:@"circleShaperLayer"];
    if (layer) {
        [layer removeFromSuperlayer];
        if (self.clickBlock) {
            self.clickBlock();
        }
    }
}
@end
