//
//  NearByDetailViewController.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityItem.h"

@interface NearByDetailViewController : UIViewController
@property (nonatomic,strong) CityItem *modell;
@property (nonatomic,assign)BOOL        isfave;
@end
