//
//  GetUserHelp.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/14.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetUserHelp : NSObject

@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *imgUrl;
@property (nonatomic,strong)NSString *userInfoUrl;

+ (instancetype)shareHandle;

- (void)getUserInfoWithBlock:(void(^)())userInfo;

@end
