//
//  HeaderView.m
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (void)awakeFromNib {
    // Initialization code
}

static UINib *viewNib;
+ (UINib *)viewNib
{
    if (viewNib)
        return viewNib;
    
    // Build cell nib
    viewNib = [UINib nibWithNibName:HeaderView_XIB
                             bundle:nil];
    
    return viewNib;
}
@end
