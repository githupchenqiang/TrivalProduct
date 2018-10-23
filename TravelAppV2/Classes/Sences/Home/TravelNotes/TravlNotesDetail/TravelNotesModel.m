//
//  TravelNotesModel.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/8.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "TravelNotesModel.h"

@implementation TravelNotesModel
#pragma mark   ==KVC异常处理==
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
#pragma   mark   ==懒加载==
-(NSDictionary *)poi{
    if (_poi ==nil) {
        _poi = [NSDictionary  dictionary];
    }
    return _poi;
}

-(NSDictionary *)location{
    if (_location ==nil) {
        _location = [NSDictionary dictionary];
    }
    return _location;
}

-(NSDictionary *)photo_info{
    if (_photo_info ==nil) {
        _photo_info = [NSDictionary dictionary];
    }
    return _photo_info;
}

-(NSDictionary *)place{
    if (_place ==nil) {
        _place = [NSDictionary dictionary];
    }
    return _place;
}

-(NSString *)description{
     return [NSString stringWithFormat:@"%@",self.text];
}
@end
