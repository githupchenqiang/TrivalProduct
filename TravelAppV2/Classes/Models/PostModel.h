//
//  PostModel.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/12.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostModel : NSObject
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *byUsername;

@property (nonatomic,strong) NSString *createdAt;


@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *contentImgURL;
@property (nonatomic,strong) NSString *userImgURL;


@end
