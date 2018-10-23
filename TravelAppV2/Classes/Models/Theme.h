//
//  Theme.h
//  travel
//
//  Created by chenqiang on 15/10/6.
//  Copyright © 2015年 CXG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Theme : NSObject
//图片Url
@property (nonatomic,strong)NSString *img_url;
//跳转到Url
@property (nonatomic,strong)NSString *jump_url;
//子标题
@property (nonatomic,strong)NSString *sub_title;
//主标题
@property (nonatomic,strong)NSString *title;

@end
