//
//  TabBarController.m
//  TravelAppV1
//
//  Created by chenqiang on 15/10/6.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "ThemePlayViewController.h"
#import "CommunityViewController.h"
#import "MineController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
  
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"bgColor"]];
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:164 green:211 blue:238 alpha:1];
    view.frame = self.tabBar.bounds;
    [[UITabBar appearance] insertSubview:view atIndex:0];
    
    //home
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeVC.tabBarItem.title = @"首页";
    homeVC.tabBarItem.image = [[UIImage imageNamed:@"首页"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"首页Sele"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:164 green:211 blue:238 alpha:1];
    
    //主题
    ThemePlayViewController *themeVC = [[ThemePlayViewController alloc]init];
    themeVC.view.backgroundColor = [UIColor blueColor];
    UINavigationController *themeNav = [[UINavigationController alloc] initWithRootViewController:themeVC];
    themeVC.title = @"主题游";
    themeVC.tabBarItem.image = [[UIImage imageNamed:@"椰树"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    themeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"椰树Sele"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [themeVC.navigationController.navigationBar  setBackgroundImage:[UIImage imageNamed:@"bgColor"] forBarMetrics:UIBarMetricsDefault];
    
    //社区
    CommunityViewController *commVC = [[CommunityViewController alloc] init];
    commVC.view.backgroundColor = [UIColor grayColor];
    UINavigationController *commNav = [[UINavigationController alloc] initWithRootViewController:commVC];
    
    commVC.title = @"社区";
    commVC.tabBarItem.image = [[UIImage imageNamed:@"社区"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    commVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"社区Sele"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //我的
    MineController *mineVC = [[MineController alloc] init];
    mineVC.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    mineVC.title = @"我的";
    mineVC.tabBarItem.image = [[UIImage imageNamed:@"User"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     mineVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"UserSele"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
//     [mineVC.navigationController.navigationBar  setBackgroundImage:[UIImage imageNamed:@"bgColor"] forBarMetrics:UIBarMetricsDefault];
    [self setViewControllers:@[homeNav,themeNav,commNav,mineNav]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
