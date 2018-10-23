//
//  HomeHelper.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeHelper : NSObject

@property (nonatomic,strong) NSArray *bannersArr;
@property (nonatomic,strong) NSArray *suitArr;


+ (instancetype)sharedHomeHelper;

//轮播图
- (void)requestBannersWithFinished:(void (^)())result;

//适合十月旅行的地方
- (void)requestTravelPlaceWithFinished:(void (^)())result;
@end
