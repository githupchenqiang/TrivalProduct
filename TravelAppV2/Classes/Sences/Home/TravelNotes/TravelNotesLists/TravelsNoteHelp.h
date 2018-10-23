//
//  TravelsNoteHelp.h
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelsNoteHelp : NSObject
+(TravelsNoteHelp *)shareTravelsNoteData;
-(void)requestAllNewsWithFinish:(void(^)())result;
-(TravelsModel *)itemWithIndex:(NSInteger)index;
@property (nonatomic,strong) NSArray * Narray;
@property (nonatomic,assign) BOOL isRefresh;//判断是加载还是刷新

@end
