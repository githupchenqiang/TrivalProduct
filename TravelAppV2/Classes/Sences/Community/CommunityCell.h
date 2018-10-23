//
//  CommunityCell.h
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostModel.h"


typedef void(^shareBlock)(NSString*,UIImage*);

@interface CommunityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img4User;

@property (weak, nonatomic) IBOutlet UILabel *lab4UserName;
@property (weak, nonatomic) IBOutlet UILabel *lab4TravelPlace;

@property (weak, nonatomic) IBOutlet UILabel *lab4Date;

@property (weak, nonatomic) IBOutlet UIImageView *img4Scene;

@property (weak, nonatomic) IBOutlet UIButton *btn4Praise;



@property (weak, nonatomic) IBOutlet UIButton *btn4Share;


@property (nonatomic,strong) PostModel *model;
@property (weak, nonatomic) IBOutlet UILabel *lab4content;
@property (nonatomic,copy) shareBlock  myblock;

@end
