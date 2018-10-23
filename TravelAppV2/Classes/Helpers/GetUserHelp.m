//
//  GetUserHelp.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/14.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "GetUserHelp.h"

@implementation GetUserHelp

+ (instancetype)shareHandle{
    
    static GetUserHelp *userMessage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userMessage = [GetUserHelp new];
    });
    
    return userMessage;
}

- (void)getUserInfoWithBlock:(void (^)())userInfo{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:_userInfoUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        _username = responseObject[@"name"];
        _imgUrl = responseObject[@"profile_image_url"];
        userInfo();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"获取用户信息失败!");
    }];
}


@end
