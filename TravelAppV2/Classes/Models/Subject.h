//
//  Subject.h
//  travel
//
//  Created by chenqiang on 15/9/24.
//  Copyright (c) 2015年 CXG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Subject : NSObject
//图片Url
@property (nonatomic,strong)NSString *photo;
//标题
@property (nonatomic,strong)NSString *title;
//跳转的Url
@property (nonatomic,strong)NSString *url;

@end
