//
//  MSRipperVC.m
//  MSRippleLayer
//
//  Created by 清风 on 16/7/19.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSRipperVC.h"
#import "MSRipplesLayer.h"

@interface MSRipperVC ()
@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, strong) MSRipplesLayer *ripplesLayer;
@end

@implementation MSRipperVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    self.view.userInteractionEnabled = YES;
    
    self.frontView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.frontView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.frontView];
    
    self.ripplesLayer = [[MSRipplesLayer alloc] init];
    [self.view.layer insertSublayer:self.ripplesLayer below:self.frontView.layer];
    self.ripplesLayer.position = self.frontView.center;
    
    [self.ripplesLayer startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
