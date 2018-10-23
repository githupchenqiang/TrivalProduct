//
//  ImageDownload.m
//  Lesson18_UI_图片下载
//
//  Created by chenqiang on 15/8/20.
//  Copyright (c) 2015年 CXG. All rights reserved.
//

#import "ImageDownload.h"

@implementation ImageDownload
#pragma mark -- 动态方法 --

-(void)downloadImageOfAsynchronousWithURLString:(NSString *)urlString{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        UIImage *image = [UIImage imageWithData:data];
        
        self.response = response;
        self.error = connectionError;
        
        if (_delegate && [_delegate respondsToSelector:@selector(imageDownloadDidFinishDownloadImage:)]) {
            [_delegate imageDownloadDidFinishDownloadImage:image];
        }
        
    }];
    
}

-(void)downloadImageOfBlockToAsynchronousWithURL:(NSString *)urlString{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        UIImage *image = [UIImage imageWithData:data];
        
//        self.response = response;
//        self.error = connectionError;
      
         self.block(image);
        
    }];
}



#pragma mark -- 静态方法 --
+(UIImage *)downloadImageOfSynchronousWithURL:(NSString *)urlString{
    //1.创建URL
    NSURL *url = [NSURL URLWithString:urlString];
    //2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.请求图片
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}
//代理异步请求
+(void)downloadImageOfAsynchronousWithURL:(NSString *)urlString delegate:(id<ImageDownloadDelegate>)delegate{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        UIImage *image = [UIImage imageWithData:data];
        //如果代理对象不为空，并且代理对象实现了协议方法，才有传递图片的意义
        if (delegate != nil && [delegate respondsToSelector:@selector(imageDownloadDidFinishDownloadImage:)]) {
            
            [delegate imageDownloadDidFinishDownloadImage:image];
        }
    }];
}
//block异步请求
+(void)downloadImageOfAsynchronousWithURL:(NSString *)urlString block:(ImageDownloadBlock)block{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        UIImage *image = [UIImage imageWithData:data];
        
        //block将参数传递出去
        block(image);
        
    }];
                             
    
}

    









@end
