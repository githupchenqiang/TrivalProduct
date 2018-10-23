//
//  CityModel.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/15.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityModel : NSObject
@property (nonatomic,assign) NSInteger  cityId;
@property (nonatomic,copy) NSString * cityCode;
@property (nonatomic,copy) NSString * pinYinName;
@property (nonatomic,copy) NSString * cityName;
@property (nonatomic,copy) NSString * cityNameAbbr;
@end
