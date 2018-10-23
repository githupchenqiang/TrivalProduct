//
//  CommentModel.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/14.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel


//重写初始化方法
- (instancetype)initWithAVObject:(AVObject *)av{
    if (self = [super init]) {
    self.contentComment = av[@"content"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:av[@"createdAt"]];
    self.createdBy = strDate;
    
    AVUser *user = [AVQuery getUserObjectWithId:av[@"fromUser"][@"objectId"]];
    self.nickname = user[@"nickname"];
    
    AVFile *file = user[@"Avatar"];
    self.imgUrl = file.url;
    }
    return self;
}
@end
