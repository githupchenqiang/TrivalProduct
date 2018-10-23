//
//  SuitCollectionCell.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "SuitCollectionCell.h"
#import "UIImageView+WebCache.h"
@implementation SuitCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(SuitPlace *)item{
    [self.img sd_setImageWithURL:[NSURL URLWithString:item.img_url]];
    self.title.text = item.title;
    self.littleTitle.text = item.sub_title;
    
}
@end
