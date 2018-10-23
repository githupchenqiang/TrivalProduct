//
//  TravelNoteHelp.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/9.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TravelNotesModel;
@interface TravelNoteHelp : NSObject 
+(TravelNoteHelp *)shareTravelNoteDetailData;
@property (nonatomic,assign) NSInteger  TNid;
-(void)requestAllNewsWithFinish:(void(^)())result;
@property (nonatomic,strong) NSArray * SNarray;//分区不可变数组;
@property (nonatomic,strong) NSArray * Narray;
@property (nonatomic,strong) NSMutableArray * NDNarry ;

-(TravelNotesModel *)itemWithIndex:(NSInteger)index;
@end
