//
//  CommunityDetailCell.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommunityDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *lab4user;
@property (weak, nonatomic) IBOutlet UILabel *lab4name;
@property (weak, nonatomic) IBOutlet UILabel *lab4date;
@property (weak, nonatomic) IBOutlet UILabel *lab4comment;

@property (nonatomic,strong) CommentModel *item;
//- (void)drawImage;

@end
