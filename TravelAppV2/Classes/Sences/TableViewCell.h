//
//  TableViewCell.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/15.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CityModel;
@interface TableViewCell : UITableViewCell
@property (nonatomic,strong)IBOutlet UILabel * Nlabel;
@property (nonatomic,strong) CityModel * Model;
+(TableViewCell *)cellWithtableView:(UITableView *)tabelView;

@end
