//
//  CommunityDetailCell.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "CommunityDetailCell.h"

@implementation CommunityDetailCell


- (void)drawImage {
    self.lab4user.layer.cornerRadius = 15;
    self.lab4user.layer.masksToBounds = YES;
}


- (void)awakeFromNib {
    [self drawImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(CommentModel *)item{
    [_lab4user sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:[UIImage imageNamed:@"user-64"]];
    _lab4name.text = [NSString stringWithFormat:@"%@:",item.nickname];
    _lab4date.text = item.createdBy;
    _lab4comment.text = item.contentComment;
}
@end
