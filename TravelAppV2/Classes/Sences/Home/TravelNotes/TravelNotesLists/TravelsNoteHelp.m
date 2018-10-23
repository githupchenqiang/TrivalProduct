//
//  TravelsNoteHelp.m
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "TravelsNoteHelp.h"
@interface TravelsNoteHelp ()
@property (nonatomic,strong) NSMutableArray * Marray;
@property (nonatomic,strong) NSMutableDictionary *nextURLDic;
@property (nonatomic,assign) NSInteger  count;
@end
@implementation TravelsNoteHelp
+(TravelsNoteHelp *)shareTravelsNoteData{
    static  TravelsNoteHelp  * travelsNote =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        travelsNote= [TravelsNoteHelp new];
    });
    return travelsNote;
}

-(void)requestAllNewsWithFinish:(void(^)())result{
    AFHTTPSessionManager * ma = [AFHTTPSessionManager manager];
    
    NSString *urlstr = nil;
    if ([self.nextURLDic[@"next_url"] isEqualToString:KBrowseUrla]) {
        urlstr = KBrowseUrla;
    }else{
        if(self.isRefresh){
        urlstr = KBrowseUrla;
        }else{
        urlstr = self.nextURLDic[@"next_url"];
        }
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    [ma GET:urlstr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dict =responseObject;
        NSDictionary * adict = dict[@"data"];
        self.nextURLDic[@"next_url"] = [NSString stringWithFormat:@"http://api.breadtrip.com/v2/index/?next_start=%@",adict[@"next_start"]];
        NSArray * bdict =adict[@"elements"];
        
        if ([urlstr isEqualToString:KBrowseUrla]) {
            for (int i = 7;i<15; i++) {
                if (i==9||i==12) {
                    continue;
                }
                NSDictionary * dict = bdict[i];
                NSDictionary * eict =dict[@"data"][0];
                TravelsModel * traves = [TravelsModel new];
                [traves  setValuesForKeysWithDictionary:eict];
                if ([self.Marray indexOfObject:traves]!= NSNotFound) {

                }else{
                    [self.Marray addObject:traves];
                }
            }
        }
        else{
            for (NSDictionary * dict in bdict) {
                NSDictionary * eict =dict[@"data"][0];
                TravelsModel * traves = [TravelsModel new];
                [traves setValuesForKeysWithDictionary:eict];
                [self.Marray addObject:traves];
            }
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            result();
        });

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
});
}
-(TravelsModel *)itemWithIndex:(NSInteger)index{
    return self.Marray[index];
}

#pragma mark   ==Marray的懒加载==
-(NSMutableArray *)Marray{
    if (_Marray==nil) {
        _Marray = [NSMutableArray arrayWithCapacity:10];
    }
    return _Marray;
}

-(NSArray *)Narray{
   return [self.Marray  mutableCopy];
}

-(NSMutableDictionary *)nextURLDic{
    if (!_nextURLDic) {
        _nextURLDic = [NSMutableDictionary dictionary];
        [_nextURLDic setObject:KBrowseUrla forKey:@"next_url"];
    }
    return _nextURLDic;
}

@end
