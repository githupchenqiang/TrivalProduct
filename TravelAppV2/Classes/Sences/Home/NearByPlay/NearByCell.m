//
//  NearByCell.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "NearByCell.h"

@implementation NearByCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(CityItem *)item{
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:item.mImageUrl]];
    self.title.text  = item.productName;
    self.littleTitle.text = item.productTitleContent;
}
@end
