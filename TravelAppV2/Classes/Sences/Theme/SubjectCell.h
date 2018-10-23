//
//  SubjectCell.h
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"

@interface SubjectCell : UICollectionViewCell
//图片，对应subject  model中的图片URL photo
@property (weak, nonatomic) IBOutlet UIImageView *subImg4Image;

@property (nonatomic,strong)Subject *item;

@end
