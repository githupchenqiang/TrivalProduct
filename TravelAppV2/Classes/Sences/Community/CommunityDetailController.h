//
//  CommunityDetailController.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostModel.h"
@interface CommunityDetailController : UIViewController
@property (nonatomic,strong) PostModel *item;



- (instancetype)initWithModle:(PostModel *)model;
@end
