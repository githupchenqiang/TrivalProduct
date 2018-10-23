//
//  SuitplaceViewController.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/8.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "SuitplaceViewController.h"

@interface SuitplaceViewController ()<UIWebViewDelegate>

@end

@implementation SuitplaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    //    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/11660.html"]]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('m-head')[0].style.display = 'none'"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('cityPoiSort')[0].getElementsByTagName('li')[2].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('cityPoiSort')[0].getElementsByTagName('li')[3].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('cityPoiSort')[0].getElementsByTagName('li')[4].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('cityPoiSort')[0].getElementsByTagName('li')[5].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('article')[2].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('postHead')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('album_num')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('tp_links')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('note_tags')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(' footer')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('note')[0].getElementsByTagName('div')[405].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:
     @"var obj=document.getElementsByClassName('note')[0].getElementsByTagName('a');"
     "for(var i=0;i<obj.length;i++)"
     "{ "
     "var objVal=obj[i];"
     "objVal.href='JAVASCRIPT:void(0)';"
     "}"];
    
}

@end
