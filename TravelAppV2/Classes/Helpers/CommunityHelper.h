//
//  CommunityHelper.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/12.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  社区
 */
@interface CommunityHelper : NSObject

@property (nonatomic,strong) NSArray *postsArr;
@property (nonatomic,strong) NSArray *commentsArr;

+ (instancetype)shareCommuntiyHelper;

/**
 *  得到所有说说
 */
- (void)getAllPostsWhenFinished:(void (^)())result;

/**
 *  得到所有评论
 */
- (void)getAllCommentByPostId:(NSString *)postID withFinished:(void (^)())result;
@end
