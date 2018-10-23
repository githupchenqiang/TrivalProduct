//
//  LocationViewController.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/14.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^passValueBlock)(NSString*);
@interface LocationViewController : UIViewController

@property (nonatomic,copy) passValueBlock   myblock;
@property (nonatomic,strong)NSString        *CityName;

@end
