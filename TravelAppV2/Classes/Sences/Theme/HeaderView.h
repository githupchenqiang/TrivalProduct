//
//  HeaderView.h
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HeaderView_ID                   @"HeaderViewID"
#define HeaderView_XIB                  @"header"
#define HeaderView_SIZE(direction)      (direction == UICollectionViewScrollDirectionHorizontal) ? CGSizeMake(0, 0) : CGSizeMake(self.view.frame.size.width, 25)

@interface HeaderView : UICollectionReusableView
//区头label
@property (weak, nonatomic) IBOutlet UILabel *title4Label;


// View nib
+ (UINib *)viewNib;
@end
