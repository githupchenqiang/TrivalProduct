//
//  SubjectCell.m
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "SubjectCell.h"
#import "ImageDownload.h"

@implementation SubjectCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(Subject *)item{
    

    [ImageDownload downloadImageOfAsynchronousWithURL:item.photo block:^(UIImage *image) {
        self.subImg4Image.image = image;
    }];

}
@end
