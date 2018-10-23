//
//  TravelNotesFrame.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/8.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TravelNotesModel;
@interface TravelNotesFrame : NSObject
@property (nonatomic,assign,readonly) CGRect  textTitleFrame;//文本的frame
@property (nonatomic,assign,readonly) CGRect  iamgeViewFrame;//背景图的frame
@property (nonatomic,assign,readonly) CGRect  imageClockF;//时钟的frame
@property (nonatomic,assign,readonly) CGRect  textViewF;//点在和留言的视图frame
@property (nonatomic,assign,readonly) CGRect  imageVF; //
@property (nonatomic,assign,readonly) CGRect textAddressF;
@property (nonatomic,assign,readonly) CGRect  textDateF;
@property (nonatomic,assign,readonly) CGRect addressViewF;

@property (nonatomic,assign,readonly) CGFloat cellHegth;//cell的高度

@property (nonatomic,strong) TravelNotesModel * traveNotes;





















@property (nonatomic,strong) TravelNotesModel * traveNotesModel;
@end
