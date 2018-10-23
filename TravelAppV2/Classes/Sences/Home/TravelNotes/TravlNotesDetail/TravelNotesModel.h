//
//  TravelNotesModel.h
//  TravelAppV2
//
//  Created by chenqiang on 15/10/8.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelNotesModel : NSObject
@property (nonatomic,copy) NSString * text; //文本
@property (nonatomic,copy) NSString * photo_1600; //背景图
@property (nonatomic,strong) NSDictionary * poi;
@property (nonatomic,copy) NSString * photo_s; //大图
@property (nonatomic,assign) NSInteger   day; //第几天
@property (nonatomic,strong) NSDictionary * location;//坐标位置
@property (nonatomic,strong) NSDictionary * photo_info;
@property (nonatomic,strong) NSDictionary * place;
@property (nonatomic,copy) NSString * local_time;    //当地时间
@property (nonatomic,assign) NSInteger  comments;     //留言人数
@property (nonatomic,assign) NSInteger recommendations;//点赞人数
@property (nonatomic,assign) NSInteger  length;

@end
