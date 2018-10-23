//
//  ThemeCell.m
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "ThemeCell.h"
#import "ImageDownload.h"

@implementation ThemeCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - Utils
static UINib *cellNib;
+ (UINib*)cellNib
{
    if (cellNib)
        return cellNib;
    
    // Build cell nib
    cellNib = [UINib nibWithNibName:ThemeCell_XIB
                             bundle:nil];
    
    return cellNib;
}

- (void)setItem:(Theme *)item{

    [ImageDownload downloadImageOfAsynchronousWithURL:item.img_url block:^(UIImage *image) {
        self.img4Theme.image = image;
    }];

    self.title4label.text = item.title;
    self.subtitle4Label.text = item.sub_title;
}
@end
