//
//  ThemeHelp.m
//  travel
//
//  Created by chenqiang on 15/10/6.
//  Copyright © 2015年 CXG. All rights reserved.
//

#import "ThemeHelp.h"
#import "AFHTTPSessionManager.h"
#import "Theme.h"
#import "Subject.h"



@implementation ThemeHelp

+(instancetype)shareHandle{
    
    static ThemeHelp *theme = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        theme = [ThemeHelp new];
    });
    return theme;
}

//发现下一站数据请求
- (void)requestSubjectWithSub:(void(^)())subject{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:RecURL parameters:nil success:^void(NSURLSessionDataTask * task, id responseObject) {
        
        NSArray *subArr = [[responseObject objectForKey:@"data"]objectForKey:@"subject"];
        
        for (NSDictionary *dic in subArr) {
            Subject *subject = [Subject new];
            [subject setValuesForKeysWithDictionary:dic];
            subject.url = dic[@"url"];
            
            [self.subjectArr addObject:subject];
        }
        subject();
    } failure:^void(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
    }];
    
}

//主题游（花样撒野）数据请求
-(void)fecthThemeWithBlock:(void (^)())theme{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:THEMEUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray *themeArray = [[responseObject objectForKey:@"data"]objectForKey:@"list"];
        
        for(NSDictionary *dic in themeArray){
            
            Theme *theme = [Theme new];
            [theme setValuesForKeysWithDictionary:dic];
            [self.themeArr addObject:theme];
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}


#pragma mark -- 懒加载 --

-(NSMutableArray *)subjectArr{
    
    if (_subjectArr == nil) {
        _subjectArr = [NSMutableArray array];
    }
    return _subjectArr;
}

-(NSMutableArray *)themeArr{
    
    if (_themeArr == nil) {
        _themeArr = [NSMutableArray array];
    }
    return _themeArr;
}
@end
