//
//  CityItem.h
//  TravelAppV1
//
//  Created by chenqiang on 15/10/6.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  "周边游"模块 model
 
 
 */
@interface CityItem : NSObject

@property (nonatomic,assign) NSInteger productId;  //点击cell详情..所需的id
@property (nonatomic,strong) NSString *productName;
@property (nonatomic,strong) NSString *productDescription;
@property (nonatomic,strong) NSString *productTitle;
@property (nonatomic,strong) NSString *productTitleContent;

@property (nonatomic,strong) NSString *mImageUrl;  //需要拼接http://cdn1.jinxidao.com/
@property (nonatomic,strong) NSString *url600x360;   //需要拼接
@property (nonatomic,strong) NSString *url;   //需要拼接
@property (nonatomic,strong) NSString *address;





@end
