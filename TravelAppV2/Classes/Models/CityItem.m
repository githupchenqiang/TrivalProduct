//
//  CityItem.m
//  TravelAppV1
//
//  Created by chenqiang on 15/10/6.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "CityItem.h"

@implementation CityItem


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"mImageUrl"]) {
        self.mImageUrl = [NSString stringWithFormat:@"http://cdn1.jinxidao.com/%@",value];
    }
    if ([key isEqualToString:@"url"]) {
        self.url = [NSString stringWithFormat:@"http://cdn1.jinxidao.com/%@",value];
    }
    if ([key isEqualToString:@"url600x360"]) {
        self.url600x360 = [NSString stringWithFormat:@"http://cdn1.jinxidao.com/%@",value];
    }
    if ([key isEqualToString:@"productId"]){
        self.productId = [value integerValue];
    }
    
}
@end
