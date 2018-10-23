//
//  FaveDetailViewController.m
//  TravelAppV2
//
//  Created by AmpleSky on 2018/10/23.
//  Copyright © 2018年 蓝鸥. All rights reserved.
//

#import "FaveDetailViewController.h"
#import "SDCycleScrollView.h"
#import "NearByModel.h"
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>
#import "FMDBSource.h"
#import "UIView+HUD.h"
@interface FaveDetailViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) SDCycleScrollView *sdc;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *titleLittleLabel;
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) NSMutableArray *imgArr;
@property (nonatomic,strong) NearByModel *nearModel;
@property (nonatomic,strong)UIBarButtonItem         *buttonItem;
@property (nonatomic,strong)UIBarButtonItem         *CollecbuttonItem;
@property (nonatomic,assign)BOOL                    isCollec;


@end

@implementation FaveDetailViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _isCollec = NO;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.scrollView.delegate = self;
        _scrollView.directionalLockEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_scrollView];
        
        //轮播图
        self.sdc = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
        _sdc.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _sdc.dotColor = [UIColor yellowColor];
        _sdc.placeholderImage = [UIImage imageNamed:@"j"];
        [self.scrollView addSubview:_sdc];
        
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, kScreenWidth, 25)];
        _titleLabel.font = [UIFont monospacedDigitSystemFontOfSize:15 weight:4];
        [self.scrollView addSubview:_titleLabel];
        
        //小标题
        self.titleLittleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, kScreenWidth, 60)];
        
        _titleLittleLabel.textAlignment =  NSTextAlignmentJustified;
        _titleLittleLabel.textColor = [UIColor lightGrayColor];
        _titleLittleLabel.font = [UIFont monospacedDigitSystemFontOfSize:13 weight:5];
        [self.scrollView addSubview:_titleLittleLabel];
        //webView
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 280, kScreenWidth, self.view.frame.size.height)];
        self.webView.delegate = self;
        [self.scrollView addSubview:_webView];
        self.navigationItem.rightBarButtonItem = self.buttonItem;
    }
    return self;
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


- (UIBarButtonItem *)CollecbuttonItem
{
    if (!_CollecbuttonItem) {
        UIImage *image = [UIImage imageNamed:@"收藏"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _CollecbuttonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(Collection)];
    }
    return _CollecbuttonItem;
}


- (void)Collection{
    if (!_isCollec) {
        if([[FMDBSource DefaultDataSource] openDB]){
            BOOL result = [[FMDBSource DefaultDataSource] insertInToDataModel:self.modell ModelID:self.modell.productName];
            if (result) {
                UIImage *image = [UIImage imageNamed:@"收藏Collec"];
                image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                _CollecbuttonItem.image = image;
                _isCollec = YES;
                [self.view showSuccess:@"收藏成功"];
            }
        }
    }
}



- (void)buttonItemAction{
    [self shareControlWithUrl:_nearModel.recommendTripStr];
}

- (void)shareControlWithUrl:(NSString *)url
{
    __weak typeof (self)weakSelf = self;
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        if (platformType == UMSocialPlatformType_QQ) {
            
            NSString *new_url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [weakSelf shareTextToPlatformType:UMSocialPlatformType_QQ ShareUrl:new_url];
        }else if (platformType == UMSocialPlatformType_WechatSession)
        {
            [weakSelf shareTextToPlatformType:UMSocialPlatformType_WechatSession ShareUrl:url];
        }else if (platformType == UMSocialPlatformType_WechatTimeLine)
        {
            [weakSelf shareTextToPlatformType:UMSocialPlatformType_WechatSession ShareUrl:url];
        }else if (platformType == UMSocialPlatformType_Qzone)
        {
            
            NSString *new_url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [weakSelf shareTextToPlatformType:UMSocialPlatformType_Qzone ShareUrl:new_url];
        }
    }];
}

- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType ShareUrl:(NSString *)url
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    NSURL *imageUrl = [NSURL URLWithString:@""];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"" descr:@"" thumImage:image];
    //设置网页地址
    shareObject.webpageUrl = @"";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
        }else{
            
        }
    }];
    
}





- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:kNearByPalyDettail(self.modell.productId) parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        _nearModel = [NearByModel new];
        [_nearModel setValuesForKeysWithDictionary:dict];
        //        NSLog(@"%@",_nearModel);
        self.titleLabel.text = _nearModel.productName;
        self.titleLittleLabel.text = _nearModel.mainTitle;
        //        NSLog(@"%@",_nearModel.recommendTripStr);
        [self.webView loadHTMLString:_nearModel.recommendTripStr baseURL:nil];
        
        self.imgArr = [NSMutableArray array];
        for (NSDictionary *ddd in dict[@"imageList"]) {
            
            [self.imgArr addObject:[NSString stringWithFormat:@"http://cdn1.jinxidao.com/%@",ddd[@"url"]]];
        }
        self.sdc.imageURLStringsGroup = self.imgArr;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backMain:)];
    self.navigationItem.leftBarButtonItem =barButtonItem;
    
}
#pragma mark  ==navigationItem==触发方法
-(void)backMain:(UIBarButtonItem *)abuttonItem{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma --mark webView delegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth = 300.0;" // UIWebView中显示的图片宽度
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}
@end
