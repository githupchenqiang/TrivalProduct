//
//  CommentModel.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/14.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (nonatomic,strong) NSString *nickname;  //昵称
@property (nonatomic,strong) NSString *contentComment;//评论内容
@property (nonatomic,strong) NSString *createdBy;   //评论时间
@property (nonatomic,strong) NSString *imgUrl;

//重写初始化方法

- (instancetype)initWithAVObject:(AVObject *)av;
@end
