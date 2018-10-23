//
//  FMDBSource.m
//  TravelAppV2
//
//  Created by AmpleSky on 2018/10/23.
//  Copyright © 2018年 蓝鸥. All rights reserved.
//

#import "FMDBSource.h"
#import "FMDB.h"
#import "NearByModel.h"



@implementation FMDBSource
{
    FMDatabase      *_DB;
    int             mark_Collection;
}
FMDBSource *souce = nil;
+ (FMDBSource *)DefaultDataSource{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        souce = [[FMDBSource alloc]init];
        
    });
    return souce;
}


- (BOOL)openDB{
    
    _Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [_Path stringByAppendingPathComponent:@"Collec.sqlite"];
    _DB = [FMDatabase databaseWithPath:fileName];
    [_DB open];
    if ([_DB open]) {
        NSLog(@"打开数据库成功");
        [self CreatFile];
        return YES;
    }else
    {
        NSLog(@"打开失败");
        return NO;
    }
}
//[self.img sd_setImageWithURL:[NSURL URLWithString:item.mImageUrl]];
//self.title.text  = item.productName;
//self.littleTitle.text = item.productTitleContent;

- (BOOL)CreatFile{
    BOOL result = [_DB executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, mImageUrl text NOT NULL,productName text NOT NULL,productTitleContent text NOT NULL, productId integer NOT NULL);"];
    if (result) {
        NSLog(@"创建表成功");
        return  YES;
    }else{
        NSLog(@"创建表失败");
        return  NO;
    }
}


- (BOOL)insertInToDataModel:(CityItem *)model ModelID:(NSString *)NameID{

    BOOL result = [_DB executeUpdate:@"INSERT INTO t_student (mImageUrl,productName,productTitleContent,productId) VALUES (?,?,?,?)",model.mImageUrl,model.productName,model.productTitleContent,@(model.productId)];
    if (result) {
        NSLog(@"插入成功");
        [_DB close];
        return YES;
    }else
    {
        NSLog(@"插入失败");
         [_DB close];
        return NO;
    }
}

- (BOOL)delegateDatabasewith:(NSInteger)ID{
 
   BOOL result = [_DB executeUpdate:@"delete from t_student where productId = ?",@(ID)];
    if (result) {
        NSLog(@"删除成功");
         [_DB close];
        return YES;
    }else
    {
        NSLog(@"删除失败");
         [_DB close];
        return NO;
    }
}


- (NSArray *)SearchDataBse{
     NSMutableArray *resultArray = [NSMutableArray array];
    FMResultSet * resultSet = [_DB executeQuery:@"select * from t_student"];
   
    while ([resultSet next]) {
        CityItem *model = [[CityItem alloc]init];
        
        model.mImageUrl = [resultSet objectForColumnName:@"mImageUrl"];
        model.productName = [resultSet objectForColumnName:@"productName"];
        model.productTitleContent = [resultSet objectForColumnName:@"productTitleContent"];
        model.productId = [[resultSet objectForColumnName:@"productId"] integerValue];
        [resultArray addObject:model];
    }
     [_DB close];
    return [resultArray copy];
}









@end
