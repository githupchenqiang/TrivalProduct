//
//  TravelDetailCell.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/8.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TravelNotesFrame;
@interface TravelDetailCell : UITableViewCell
+(TravelDetailCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) TravelNotesFrame * travelNoteFrame;

@end
