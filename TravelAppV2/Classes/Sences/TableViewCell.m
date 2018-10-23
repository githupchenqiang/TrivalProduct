//
//  TableViewCell.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/15.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "TableViewCell.h"
#import "CityModel.h"

@implementation TableViewCell
+(TableViewCell *)cellWithtableView:(UITableView *)tabelView{
    static NSString * const sting = @"cell";
    TableViewCell * Cell = [tabelView dequeueReusableCellWithIdentifier:sting];
    if (Cell ==nil) {
        Cell =[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:nil options:nil].firstObject;
        [Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return Cell;
}

-(void)setModel:(CityModel *)Model{
  self.Nlabel.text = Model.cityName;
}

@end
