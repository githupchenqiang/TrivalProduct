//
//  TravelsCell.h
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelsModel.h"
@interface TravelsCell : UITableViewCell
+(TravelsCell *)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic,strong) IBOutlet UILabel * picName;
@property (nonatomic,strong) IBOutlet UILabel * picDate;
@property (nonatomic,strong) IBOutlet UILabel * picDay;
@property (nonatomic,strong) IBOutlet UILabel * picBrowseCount;
@property (nonatomic,strong) IBOutlet UILabel * picPlace;
@property (nonatomic,strong) IBOutlet UIImageView * picUserIcon;
@property (nonatomic,strong) IBOutlet UIImageView * picBackGroud;
@property (nonatomic,strong) IBOutlet UILabel * picUserName;

@property (nonatomic,strong) TravelsModel * travel;

@end
