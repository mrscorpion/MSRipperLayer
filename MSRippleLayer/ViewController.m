//
//  ViewController.m
//  MSRippleLayer
//
//  Created by mr.scorpion on 16/7/19.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "ViewController.h"
#import "MSRipperView.h"
#import "MSRipperViewController.h"

@interface ViewController ()
@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(next)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
    
    [self createRipplebuttonUI];
}
- (void)next
{
    [self presentViewController:[MSRipperViewController new] animated:YES completion:nil];
}

- (void)createRipplebuttonUI
{
    //outter round button
    MSRipperView * outerRoundFlashbutton = [[MSRipperView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    outerRoundFlashbutton.buttonType = MSFlashbuttonTypeOuter;
    outerRoundFlashbutton.layer.cornerRadius = 25;
    outerRoundFlashbutton.flashColor = [UIColor colorWithRed:73/255.0f green:146/255.0f blue:236/255.0f alpha:1];
    outerRoundFlashbutton.backgroundColor = [UIColor colorWithRed:73/255.0f green:146/255.0f blue:236/255.0f alpha:1];
    outerRoundFlashbutton.clickBlock = ^(void) {
        NSLog(@"------------>执行点击事件1 回调方法.");
    };
    [self.view addSubview:outerRoundFlashbutton];
    
    //outter rectangle button
    MSRipperView * outerrectanglebutton = [[MSRipperView alloc] initWithFrame:CGRectMake(200, 50, 100, 30)];
    outerrectanglebutton.buttonType = MSFlashbuttonTypeOuter;
    [outerrectanglebutton setText:@"点击事件2 回调" withTextColor:[UIColor whiteColor]];
    outerrectanglebutton.textlabel.font = [UIFont systemFontOfSize:10.0f];
    outerrectanglebutton.flashColor = [UIColor colorWithRed:73/255.0f green:146/255.0f blue:236/255.0f alpha:1];
    outerrectanglebutton.backgroundColor = [UIColor colorWithRed:73/255.0f green:146/255.0f blue:236/255.0f alpha:1];
    outerrectanglebutton.clickBlock = ^(void) {
        NSLog(@"------------>执行点击事件2 回调方法.");
    };
    [self.view addSubview:outerrectanglebutton];
    
    //inner flash button
    MSRipperView * innerflashbutton = [[MSRipperView alloc] initWithFrame:CGRectMake(100, 200, 160, 30)];
    innerflashbutton.layer.masksToBounds = YES;
    innerflashbutton.layer.cornerRadius = 5;
    innerflashbutton.backgroundColor = [UIColor colorWithRed:73/255.0f green:146/255.0f blue:236/255.0f alpha:1];
    [innerflashbutton setText:@"点击事件3 回调" withTextColor:[UIColor blackColor]];
    innerflashbutton.textlabel.font = [UIFont systemFontOfSize:10.0f];
    
    innerflashbutton.clickBlock = ^(void) {
        NSLog(@"------------>执行点击事件3 回调方法.");
    };
    [self.view addSubview:innerflashbutton];
    
    //inner flash button
    MSRipperView * innerRipplebutton = [[MSRipperView alloc] initWithFrame:CGRectMake(100, 300, 160, 30)];
    innerRipplebutton.layer.masksToBounds = YES;
    innerRipplebutton.layer.cornerRadius = 5;
    innerRipplebutton.backgroundColor = [UIColor colorWithRed:73/255.0f green:146/255.0f blue:236/255.0f alpha:1];
    innerRipplebutton.flashColor = [UIColor orangeColor];
    [innerRipplebutton setText:@"点击事件4 回调" withTextColor:nil];
    innerRipplebutton.textlabel.font = [UIFont systemFontOfSize:10.0f];
    
    innerRipplebutton.clickBlock = ^(void) {
        NSLog(@"------------>执行点击事件4 回调方法.");
    };
    [self.view addSubview:innerRipplebutton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
