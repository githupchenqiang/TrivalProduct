//
//  GuideFigure.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/12.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "GuideFigure.h"
@interface GuideFigure () <UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView * ascrollView;
@property (nonatomic,strong) UIPageControl * aPateControl;
@end
#define KWeigth self.view.frame.size.width
#define KHeigth self.view.frame.size.height
@implementation GuideFigure
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupFirstLanchView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)setupFirstLanchView{
    [self setupScrollView];
    [self aPateControl];
}

- (void)setupScrollView

{
    self.ascrollView.contentSize =CGSizeMake(self.view.frame.size.width*4, [UIScreen mainScreen].bounds.size.height);
    
    for (int i = 0; i < 4; i++) {
       
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWeigth * i,0,KWeigth, KHeigth)];
        imageView.userInteractionEnabled = YES;
        imageView.image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]];
        UIButton * abutton = [UIButton  buttonWithType:UIButtonTypeRoundedRect];
        abutton.frame = CGRectMake(KWeigth-215,KHeigth -150,100,40);
        abutton.center = CGPointMake(KWeigth/2, KHeigth-150);
        [abutton setTitle:@"立即体验" forState:UIControlStateNormal];
        [abutton setTintColor:[UIColor whiteColor]];
        [abutton setBackgroundColor:[UIColor clearColor]];
        abutton.layer.cornerRadius = 10;
        abutton.layer.masksToBounds=YES;
        abutton.layer.borderWidth = 2;
        CGColorSpaceRef colorSpace =CGColorSpaceCreateDeviceRGB();
        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha
        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 0.7, 0.7, 0.7, 1 });
        // 设置边框颜色
        abutton.layer.borderColor = borderColorRef;
        [abutton addTarget:self action:@selector(abuttonTouch:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:abutton];
        [imageView  bringSubviewToFront:abutton];
        [self.ascrollView addSubview:imageView];
    }
    [self.view addSubview:self.ascrollView];
}


#pragma  mark  --UIScrollView的代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.aPateControl.currentPage = scrollView.contentOffset.x /KWeigth;
}

#pragma mark  --懒加载--

-(UIScrollView *)ascrollView{
    if (_ascrollView ==nil) {
        _ascrollView =[[UIScrollView alloc]initWithFrame:self.view.frame];
        _ascrollView.delegate =self;
        //关闭水平方向上的滚动条
        _ascrollView.showsHorizontalScrollIndicator =NO;
        //是否可以整屏滑动
        _ascrollView.pagingEnabled =YES;
        _ascrollView.bounces =NO;
        _ascrollView.contentSize =CGSizeMake(KWeigth *4, KHeigth);
        [self.view addSubview:_ascrollView];
    }
    return _ascrollView;
}

-(UIPageControl *)aPateControl{
    if (_aPateControl ==nil) {
        _aPateControl =
        _aPateControl = [[UIPageControl alloc] initWithFrame:CGRectMake(35, KHeigth -40, 300, 20)];
        _aPateControl.center =CGPointMake(KWeigth/2, KHeigth-40);
        //设置表示的页数
        _aPateControl.numberOfPages =4;
        //设置选中的页数
        _aPateControl.currentPage =0;
        //设置未选中点的颜色
        _aPateControl.pageIndicatorTintColor = [UIColor grayColor];
        //设置选中点的颜色
        _aPateControl.currentPageIndicatorTintColor =[UIColor blackColor];
        //添加响应事件
        [_aPateControl addTarget:self action:@selector(handlePageControl:)forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_aPateControl];
    }
    return _aPateControl;
}
#pragma mark   ==触发方法==
-(void)abuttonTouch:(UIButton *)abutton{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController  * vc = [story instantiateViewControllerWithIdentifier:@"MainVC"];
    self.view.window.rootViewController = vc;
}
- (void)handlePageControl:(UIPageControl *)pageControl
{
    //切换pageControl .对应切换scrollView不同的界面
    [self.ascrollView setContentOffset:CGPointMake(KWeigth * pageControl.currentPage,0)animated:YES];
}

@end
