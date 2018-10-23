//
//  CommunityHelper.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/12.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "CommunityHelper.h"
#import "PostModel.h"
#import "CommentModel.h"

@interface CommunityHelper ()
@property (nonatomic,strong) NSMutableArray *postsMutArr;   //说说哦
@property (nonatomic,strong) NSMutableArray *commentsMutArr;  //评论

@end

@implementation CommunityHelper

+ (instancetype)shareCommuntiyHelper{
    static CommunityHelper *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [CommunityHelper new];
    });
    return handle;
}

- (void)getAllPostsWhenFinished:(void (^)())result1{
    if(self.postsMutArr.count > 0){
        [self.postsMutArr removeAllObjects];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *cql = [NSString stringWithFormat:@"select * from %@",@"Post"];
        [AVQuery doCloudQueryInBackgroundWithCQL:cql pvalues:nil callback:^(AVCloudQueryResult *result, NSError *error) {
            if (!error) {
                for (AVObject *ob in result.results) {
                    PostModel *pm = [PostModel new];
                    pm.content = ob[@"content"];
                    AVFile *file = ob[@"imageComments"];
                    [AVFile getFileWithObjectId:file.objectId withBlock:^(AVFile *file, NSError *error) {
                        pm.contentImgURL = file.url;
                    }];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"MM月dd日,HH点"];
                    NSString *strDate = [dateFormatter stringFromDate:ob[@"createdAt"]];
                    pm.createdAt = strDate;
                    
                    //根据objectId  取到user
                    AVUser *user = [AVQuery getUserObjectWithId:ob[@"byUser"][@"objectId"]];
                    AVFile *f = user[@"Avatar"];
                    pm.userImgURL = f.url;
                    
                    pm.byUsername = user[@"nickname"];
                    pm.objectId = ob[@"objectId"];
                    [self.postsMutArr addObject:pm];     
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    result1();
                });
            }else{
            }
        }];
    });

}


- (void)getAllCommentByPostId:(NSString *)postID withFinished:(void (^)())result{
    if (_commentsMutArr.count > 0 ) {
        [_commentsMutArr removeAllObjects];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AVQuery *query = [AVQuery queryWithClassName:@"Comment"];
        [query whereKey:@"toPost" equalTo:[AVObject objectWithoutDataWithClassName:@"Post" objectId:postID]];
        NSLog(@"%@",postID);
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            for (AVObject *av in objects) {
                CommentModel *cm = [[CommentModel alloc] initWithAVObject:av];
                [self.commentsMutArr addObject:cm];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                result();
            });
        }];
        
    });

}
#pragma mark --load lazy
- (NSMutableArray *)postsMutArr{
    if (!_postsMutArr) {
        _postsMutArr = [NSMutableArray array];
    }
    return _postsMutArr;
}
- (NSArray *)postsArr{
    return [_postsMutArr mutableCopy];
}

- (NSMutableArray *)commentsMutArr{
    if (!_commentsMutArr) {
        _commentsMutArr = [NSMutableArray array];
    }
    return _commentsMutArr;
}

- (NSArray *)commentsArr{
    return [_commentsMutArr mutableCopy];
}
@end
