//
//  NearByHelper.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/8.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "NearByHelper.h"
#import "CityItem.h"

@interface NearByHelper ()
@property (nonatomic,strong) NSMutableArray *nearByMutArr;

@end

@implementation NearByHelper


+ (instancetype)shareNearByHelper{
    static NearByHelper *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [NearByHelper new];
    });
    return handle;
}

- (void)requestNearByPlace:(NSString *)cityName WithFinised:(void (^)())result{
    if (cityName == nil) {
        cityName = @"苏州";
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSString *url = [NSString stringWithFormat:@"%@%@",kNeaarByPlayURL,cityName];
        NSString *codeURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:codeURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *dataArr = responseObject[@"data"][@"items"];
            for (NSDictionary *dic in dataArr) {
                CityItem *ci = [CityItem new];
                [ci setValuesForKeysWithDictionary:dic];
                [self.nearByMutArr addObject:ci];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                result();
            });
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];
        
    });
}

- (void)requestNearByPlace:(NSString *)cityName page:(NSInteger)page WithFinised:(void (^)(id responseObject))result  fail:(void (^)())failresult{
    
    NSString *base = [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=%ld&version=4.3.1&sort=n&province=1&system=iOS&pageSize=20&channel=AppStore&city=%@",page,cityName];
    NSString *codeURL = [base stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:codeURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        result(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failresult();
    }];
    
    
}


#pragma mark--load lazy

- (NSMutableArray *)nearByMutArr{
    if (!_nearByMutArr) {
        _nearByMutArr  = [NSMutableArray array];
    }
    return _nearByMutArr;
}

- (NSArray *)nearByArr{
    return [_nearByMutArr mutableCopy];
}
@end
