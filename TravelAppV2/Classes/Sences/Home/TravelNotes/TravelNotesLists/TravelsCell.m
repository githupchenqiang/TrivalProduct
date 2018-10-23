//
//  TravelsCell.m
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "TravelsCell.h"

@implementation TravelsCell
+(TravelsCell *)cellWithTabelView:(UITableView *)tableView{
     static  NSString * string =@"cell";
    TravelsCell * cell = [tableView  dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TravelsCell" owner:nil options:nil].firstObject;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.layer.shadowColor  =  [UIColor blackColor].CGColor;
        cell.layer.shadowOpacity = 1.0;
        cell.layer.shadowRadius = 7.0;
        cell.layer.shadowOffset = CGSizeMake(0,4);

    }
    return cell;
}
- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.backgroundColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}

-(void)setTravel:(TravelsModel *)travel{
    [self.picBackGroud sd_setImageWithURL:[NSURL URLWithString:travel.cover_image]];
    self.picDate.text=travel.first_day;
    self.picDay.text = [NSString stringWithFormat:@"%ld天",(long)travel.day_count];
    self.picName.text = travel.name;
    self.picPlace.text = travel.popular_place_str;
    self.picBrowseCount.text = [NSString stringWithFormat:@"%ld次浏览",travel.view_count];
    [self.picUserIcon sd_setImageWithURL:[NSURL URLWithString:travel.user[@"avatar_m"]]];
    self.picUserName.text =travel.user[@"name"];
}
@end
