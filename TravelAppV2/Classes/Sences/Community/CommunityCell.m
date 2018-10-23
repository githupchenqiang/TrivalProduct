//
//  CommunityCell.m
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "CommunityCell.h"

#import "CommunityViewController.h"

@implementation CommunityCell
{
    int i;
}
- (void)setModel:(PostModel *)model{
    [self.btn4Praise setBackgroundImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
    [self.btn4Share setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.img4Scene sd_setImageWithURL:[NSURL URLWithString:model.contentImgURL] placeholderImage:[UIImage imageNamed:@"grayBg"]];
    self.lab4UserName.text = model.byUsername;
    self.lab4Date.text = model.createdAt;
    
    [self.img4User sd_setImageWithURL:[NSURL URLWithString:model.userImgURL] placeholderImage:[UIImage imageNamed:@"user-64"]];
    self.lab4content.text = model.content;
    self.lab4TravelPlace.text = @"北京";
}

- (instancetype)initWithFrame:(CGRect)frame {
    return self;
}
#pragma mark --点击分享
- (IBAction)shareContent:(id)sender {
     self.myblock(self.lab4content.text,self.img4Scene.image);
}
- (IBAction)likeAction:(id)sender {
    self.btn4Praise.layer.contents = (id)[UIImage imageNamed:(i%2==0?@"praise":@"unlike")].CGImage;
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values = @[@(0.1),@(1.0),@(1.5)];
    k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    k.calculationMode = kCAAnimationLinear;
    i++;
    [self.btn4Praise.layer addAnimation:k forKey:@"SHOW"];
}
- (void)awakeFromNib {
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
