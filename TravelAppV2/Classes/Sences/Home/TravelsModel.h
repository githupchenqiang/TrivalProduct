//
//  TravelsModel.h
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelsModel : NSObject
@property (nonatomic,copy) NSString * cover_image;
@property (nonatomic,strong) NSMutableDictionary * user;
@property (nonatomic,copy) NSString * popular_place_str;
@property (nonatomic,copy) NSString * first_day;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,assign) NSInteger  view_count;
@property (nonatomic,assign) NSInteger  day_count;
@property (nonatomic,assign) NSInteger  TDid;

@end
