//
//  NearByHelper.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/8.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearByHelper : NSObject

@property (nonatomic,strong) NSArray *nearByArr;


+ (instancetype)shareNearByHelper;
- (void)requestNearByPlace:(NSString *)cityName WithFinised:(void (^)())result;
- (void)requestNearByPlace:(NSString *)cityName page:(NSInteger)page WithFinised:(void (^)(id responseObject))result  fail:(void (^)())failresult;
@end
