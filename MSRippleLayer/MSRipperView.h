//
//  MSRipperView.h
//  MSRippleLayer
//
//  Created by mr.scorpion on 16/7/19.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MSflashbuttonDidClickBlock)(void);
typedef NS_ENUM(NSUInteger,MSFlashbuttonType) {
    MSFlashbuttonTypeInner = 0,
    MSFlashbuttonTypeOuter = 1
};

@interface MSRipperView : UIView
@property (nonatomic, strong) UILabel * textlabel;
@property (nonatomic, assign) MSFlashbuttonType buttonType;
@property (nonatomic, copy) MSflashbuttonDidClickBlock clickBlock;
@property (nonatomic, strong) UIColor * flashColor;

- (void)setText:(NSString *)text;
- (void)setTextColor:(UIColor *)textColor;
- (void)setText:(NSString *)text withTextColor:(UIColor *)textColor;
@end
