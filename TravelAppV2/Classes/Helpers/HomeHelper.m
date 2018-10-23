//
//  HomeHelper.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "HomeHelper.h"
#import "AFNetworking.h"
#import "HomeBanner.h"
#import "SuitPlace.h"

@interface HomeHelper ()
@property (nonatomic,strong) NSMutableArray *bannersMutableArr;
@property (nonatomic,strong) NSMutableArray *suitMutableArr;
@end

@implementation HomeHelper


+ (instancetype)sharedHomeHelper{
    static HomeHelper *handle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [HomeHelper new];
    });
    return handle;
}

- (void)requestBannersWithFinished:(void (^)())result{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:kBannersURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *dataArr = responseObject[@"data"][@"list"];
            
            for (NSDictionary *dic in dataArr) {
                HomeBanner *hb = [HomeBanner new];
                [hb setValuesForKeysWithDictionary:dic];
                [self.bannersMutableArr addObject:hb];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                result();
            });
        } failure:^(NSURLSessionDataTask *task, NSError *error) {

        }];
    });
}

- (void)requestTravelPlaceWithFinished:(void (^)())result{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:kHomeSuitplace parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *dataArr = responseObject[@"data"][@"list"];
            for (NSDictionary *dict in dataArr) {
                SuitPlace *sp = [SuitPlace new];
                [sp setValuesForKeysWithDictionary:dict];
                [self.suitMutableArr addObject:sp];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                result();
            });      
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];

    });
}

#pragma mark --load lazy
- (NSMutableArray *)bannersMutableArr{
    if (!_bannersMutableArr) {
        _bannersMutableArr = [NSMutableArray array];
    }
    return _bannersMutableArr;
}
- (NSArray *)bannersArr{
    return [self.bannersMutableArr mutableCopy];
}

- (NSMutableArray *)suitMutableArr{
    if (!_suitMutableArr) {
        _suitMutableArr = [NSMutableArray array];
    }
    return _suitMutableArr;
}
- (NSArray *)suitArr{
    return [_suitMutableArr mutableCopy];
}
@end
