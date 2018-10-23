//
//  FMDBSource.h
//  TravelAppV2
//
//  Created by AmpleSky on 2018/10/23.
//  Copyright © 2018年 蓝鸥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityItem.h"

@interface FMDBSource : NSObject
@property (nonatomic,strong)NSString        *Path;

+ (FMDBSource *)DefaultDataSource;
- (BOOL)openDB;
- (BOOL)insertInToDataModel:(CityItem *)model ModelID:(NSString *)NameID;
- (BOOL)delegateDatabasewith:(NSInteger)ID;
- (NSArray *)SearchDataBse;

@end
