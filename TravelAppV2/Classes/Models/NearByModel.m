//
//  NearByModel.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/8.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "NearByModel.h"

@implementation NearByModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"pr:%@ ,su:%@,mai:%@", _productName,_subTitle,_mainTitle];
}
@end
