//
//  CithHelp.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/15.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "CithHelp.h"
#import "CityModel.h"
@interface  CithHelp ()
@property (nonatomic,strong) NSMutableDictionary * Mdict;
@end

@implementation CithHelp
+(CithHelp *)shareCityData{
    static  CithHelp * travelNote =nil;
    static  dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        travelNote = [CithHelp new];
    });
    return travelNote;
}

-(void)requestAllNewsWithFinish:(void (^)())result{
  AFHTTPSessionManager * ma = [AFHTTPSessionManager manager];

  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
     [ma GET:KurlCity parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
         NSDictionary * dict = responseObject[@"data"];
         self.Sarray = [dict allKeys];
         for (NSString * key  in dict) {
             NSArray * array =dict[key];
             NSMutableArray * mArray =[NSMutableArray array];
             for (NSDictionary *dict in array) {
                 CityModel * CityM = [CityModel new];
                 [CityM setValuesForKeysWithDictionary:dict];
                 [mArray addObject:CityM];
             }
             [self.Mdict setValue:mArray forKey:key];
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             result();
             
         });
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
 }];
     
});
         
  


}
-(CityModel *)itemWithNSindexth:(NSIndexPath *)indexPath{
    return self.Mdict[self.Sarray[indexPath.section]][indexPath.row];
}
#pragma mark  ==懒加载==
-(NSDictionary *)Ndict{
    return [self.Mdict mutableCopy];
  }

-(NSMutableDictionary *)Mdict{
    if (_Mdict ==nil) {
        _Mdict = [NSMutableDictionary dictionary];
    }
    return _Mdict;
}
-(NSArray *)Sarray{
    if (_Sarray ==nil) {
        _Sarray = [NSArray array];
    }
    return _Sarray;
}

@end
