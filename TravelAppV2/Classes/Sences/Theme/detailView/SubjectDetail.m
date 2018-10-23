//
//  SubjectDetail.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/8.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "SubjectDetail.h"
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>

@interface SubjectDetail ()<UIWebViewDelegate>
@property (nonatomic,strong)UIBarButtonItem         *buttonItem;
@end

@implementation SubjectDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.subItem.url]];
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView loadRequest:request];
    self.navigationItem.rightBarButtonItem = self.buttonItem;
}

- (UIBarButtonItem *)buttonItem
{
    if (!_buttonItem) {
        UIImage *image = [UIImage imageNamed:@"分享"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _buttonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(buttonItemAction)];
    }
    return _buttonItem;
}

- (void)buttonItemAction{
    [self shareControlWithUrl:self.subItem.url];
}


- (void)shareControlWithUrl:(NSString *)url
{
    __weak typeof (self)weakSelf = self;
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        if (platformType == UMSocialPlatformType_QQ) {
            [weakSelf shareTextToPlatformType:UMSocialPlatformType_QQ ShareUrl:url];
        }else if (platformType == UMSocialPlatformType_WechatSession)
        {
            [weakSelf shareTextToPlatformType:UMSocialPlatformType_WechatSession ShareUrl:url];
        }else if (platformType == UMSocialPlatformType_WechatTimeLine)
        {
            [weakSelf shareTextToPlatformType:UMSocialPlatformType_WechatSession ShareUrl:url];
        }else if (platformType == UMSocialPlatformType_Qzone)
        {
            [weakSelf shareTextToPlatformType:UMSocialPlatformType_Qzone ShareUrl:url];
        }
    }];
}

- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType ShareUrl:(NSString *)url
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    NSURL *imageUrl = [NSURL URLWithString:self.subItem.photo];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.subItem.title descr:@"" thumImage:image];
    //设置网页地址
    shareObject.webpageUrl = self.subItem.url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
        }else{
            
        }
    }];
    
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('tImgList clearfix')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('tImgList clearfix')[1].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('tImgList clearfix')[2].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('tImgList clearfix')[3].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('tImgList clearfix')[4].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('oTextList')[0].style.display = 'none'"];
    //<section class="oTextList">

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
