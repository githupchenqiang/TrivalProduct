//
//  PublicSource.m
//  TravelAppV2
//
//  Created by AmpleSky on 2018/10/15.
//  Copyright © 2018年 蓝鸥. All rights reserved.
//

#import "PublicSource.h"

@implementation PublicSource

+ (BOOL)IS_iPhoneX{
    
    return [UIScreen mainScreen].bounds.size.height >=  812 ? 1:0;
}
+ (CGFloat)NavigationBarHeight{
  return ([UIScreen mainScreen].bounds.size.height >=  812 ? 1:0) == 1 ? 88 : 64;
}
+ (CGFloat)TabbarHeight{
  return  ([UIScreen mainScreen].bounds.size.height >=  812 ? 1:0) == 1 ? (49 + 34) : 49;
}
+ (CGFloat)statusBarHeight{
  return  ([UIScreen mainScreen].bounds.size.height >=  812 ? 1:0) == 1 ? 44 : 20;
    
}


#define NavigationBarHeight = IS_iPhoneX
#define TabbarHeight = (IS_iPhoneX == 1 ? (49 + 34) : 49)
#define statusBarHeight = (IS_iPhoneX == 1 ? 44 : 20)
@end
