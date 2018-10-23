//
//  CitySModel.h
//  TravelAppV2
//
//  Created by AmpleSky on 2018/10/22.
//  Copyright © 2018年 蓝鸥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitySModel : NSObject
//<CITY_CODE>654300</CITY_CODE>
//<CITY_NAME>阿勒泰地区</CITY_NAME>
/**
 *  城市编码
 */
@property(nonatomic,assign)NSInteger CITY_CODE;
/**
 *  城市名称
 */
@property(nonatomic,copy) NSString *CITY_NAME;
@end
