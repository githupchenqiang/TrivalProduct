//
//  BarViewController.m
//  TravelAppV2
//
//  Created by lanou3g on 15/10/13.
//  Copyright © 2015年 蓝鸥. All rights reserved.
//

#import "BarViewController.h"

@interface BarViewController ()
@property (nonatomic,strong) UIBarButtonItem * homeButton;
@end

@implementation BarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  homeButton];
    
}
-(UIBarButtonItem *)homeButton{
    if (_homeButton ==nil) {
        _homeButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"首页"] style:UIBarButtonItemStylePlain target:self action:@selector(backHomePage)];
        self.navigationItem.rightBarButtonItem = _homeButton;
    }
    return _homeButton;
}

-(void)backHomePage{
    [self.navigationController  popViewControllerAnimated:YES];
}


@end
