//
//  ThemeCell.h
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme.h"


#define ThemeCell_ID     @"themeCell"
#define ThemeCell_XIB    @"ThemeCell"
//#define ThemeCell_SIZE   CGSizeMake(140, 180)

@interface ThemeCell : UICollectionViewCell
//图片 对应theme中的img_url属性
@property (weak, nonatomic) IBOutlet UIImageView *img4Theme;
//标题 对应theme中的title属性
@property (weak, nonatomic) IBOutlet UILabel *title4label;
//子标题 对应theme中的sub_title属性
@property (weak, nonatomic) IBOutlet UILabel *subtitle4Label;

@property (nonatomic,strong)Theme *item;

// Cell nib
+ (UINib *)cellNib;
@end
