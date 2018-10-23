//
//  CithHelp.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/15.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityModel;
@interface CithHelp : NSObject
+(CithHelp *)shareCityData;
-(void)requestAllNewsWithFinish:(void(^)())result;
@property (nonatomic,strong) NSArray * Sarray;//分区

@property (nonatomic,strong) NSDictionary * Ndict;
-(CityModel *)itemWithNSindexth:(NSIndexPath *)indexPath;
@end
