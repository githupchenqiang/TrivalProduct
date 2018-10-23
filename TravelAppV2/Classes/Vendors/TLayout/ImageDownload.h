//
//  ImageDownload.h
//  Lesson18_UI_图片下载
//
//  Created by chenqiang on 15/8/20.
//  Copyright (c) 2015年 CXG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//声明一个协议，代理对象执行协议方法时，将参数传递出去
@protocol ImageDownloadDelegate <NSObject>

-(void)imageDownloadDidFinishDownloadImage:(UIImage *)image;

@end

typedef void(^ImageDownloadBlock)(UIImage *image);


@interface ImageDownload : NSObject

//声明一个代理属性
@property(nonatomic,weak)id<ImageDownloadDelegate> delegate;

//声明一个Block属性
@property(nonatomic,copy)ImageDownloadBlock block;

@property(nonatomic,strong)NSURLResponse *response;
@property(nonatomic,strong)NSError *error;


#pragma mark -- 静态方法 --
//同步下载图片
+(UIImage *)downloadImageOfSynchronousWithURL:(NSString *)urlString;

//异步下载图片
//代理
+(void)downloadImageOfAsynchronousWithURL:(NSString *)urlString delegate:(id<ImageDownloadDelegate>)delegate;
//block
+(void)downloadImageOfAsynchronousWithURL:(NSString *)urlString block:(ImageDownloadBlock)block;



#pragma mark -- 动态方法 --

-(void)downloadImageOfAsynchronousWithURLString:(NSString *)urlString;

-(void)downloadImageOfBlockToAsynchronousWithURL:(NSString *)urlString;



















@end
