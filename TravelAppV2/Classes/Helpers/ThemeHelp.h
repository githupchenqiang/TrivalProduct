//
//  ThemeHelp.h
//  travel
//
//  Created by chenqiang on 15/10/6.
//  Copyright © 2015年 CXG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeHelp : NSObject

@property (nonatomic,strong)NSMutableArray *subjectArr;

@property (nonatomic,strong)NSMutableArray *themeArr;

+ (instancetype)shareHandle;

- (void)requestSubjectWithSub:(void(^)())subject;

- (void)fecthThemeWithBlock:(void (^)())theme;

@end
