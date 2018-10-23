//
//  TravelNotesDetails.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/8.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  UitableVIewControllerDelegate  <NSObject>
-(void)ModifyTheInsideOfTheSingLetonArray;
@end
@interface TravelNotesDetails : UITableViewController
+(TravelNotesDetails *)shareTravelNotesListData;
@property (nonatomic,assign) id<UitableVIewControllerDelegate>   delegate;
@end
