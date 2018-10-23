//
//  TravelNoteHelp.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/9.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "TravelNoteHelp.h"
@interface TravelNoteHelp () <UitableVIewControllerDelegate>
@property (nonatomic,strong) NSMutableArray * Marray;
@end
@implementation TravelNoteHelp
+(TravelNoteHelp *)shareTravelNoteDetailData{
    static  TravelNoteHelp * travelNote =nil;
    static  dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        travelNote= [TravelNoteHelp new];
    });
    return travelNote;
}
-(void)requestAllNewsWithFinish:(void(^)())result{
    TravelNotesDetails * travelDetails = [TravelNotesDetails shareTravelNotesListData];
    travelDetails.delegate = self;
    AFHTTPSessionManager * ma = [AFHTTPSessionManager manager];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString * urlstr =KCurrentUrl;
        [ma GET:urlstr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){

            NSDictionary * dict = responseObject;
            self.SNarray = dict[@"days"];
            for (NSDictionary *dicts in self.SNarray) {
                NSArray * array =dicts[@"waypoints"];
                [self.NDNarry addObject:dicts[@"date"]];
                for (NSDictionary * dict in array) {
                    TravelNotesModel * traveLDM = [TravelNotesModel new];
                    [traveLDM  setValuesForKeysWithDictionary:dict];
                    [self.Marray addObject:traveLDM];
                }
               }
            dispatch_async(dispatch_get_main_queue(), ^{
                result();
            });
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
     }];
    });
}
-(TravelNotesModel *)itemWithIndex:(NSInteger)index{
    return self.Marray[index];
}

#pragma mark  --懒加载
-(NSMutableArray*)Marray{
    if (_Marray ==nil) {
        _Marray = [NSMutableArray array];
    }
    return _Marray;
}

-(NSArray *)Narray{
    return [self.Marray mutableCopy];
}
-(NSArray *)SNarray{
    if (_SNarray ==nil) {
        _SNarray = [NSArray  array];
    }
    return _SNarray;
}
-(NSMutableArray *)NDNarry{
    if (_NDNarry ==nil) {
      _NDNarry =[NSMutableArray array];
    }
    return _NDNarry;
}
-(void)ModifyTheInsideOfTheSingLetonArray{
    self.Marray =nil;
}
@end
