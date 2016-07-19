//
//  MSRipplesLayer.h
//  MSRippleLayer
//
//  Created by 清风 on 16/7/19.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSRipplesLayer : CAReplicatorLayer
/**
 *  圆圈半径，用来确定圆圈Bounds
 */
@property (nonatomic, assign) CGFloat radius;
/**
 *  涟漪动画持续时间
 */
@property (nonatomic, assign) NSTimeInterval animationDuration;

/**
 *  开启动画
 */
- (void)startAnimation;
@end
