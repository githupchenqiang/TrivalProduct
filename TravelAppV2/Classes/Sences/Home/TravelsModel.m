//
//  TravelsModel.m
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "TravelsModel.h"

@implementation TravelsModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _TDid = [value integerValue];
    }
}
-(void)setValue:(id)value forKeyPath:(NSString *)keyPath{
    NSLog(@"1");
}

-(NSString *)description{
return [NSString  stringWithFormat:@"%@",self.name];
}

- (NSMutableDictionary *)user{
    if (_user ==nil) {
       _user = [NSMutableDictionary dictionary];
     }
   return _user;
}
@end
