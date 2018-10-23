//
//  CommunityViewController.m
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityCell.h"
#import "CommunityDetailController.h"
#import "CommunityHelper.h"
#import "PublishSayController.h"
#import <MJRefresh.h>
//#import <UMShare/UMShare.h>
@interface CommunityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@end
@implementation CommunityViewController
- (void)viewWillDisappear:(BOOL)animated {
    [self setHidesBottomBarWhenPushed:NO];
    [super viewDidDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CommunityCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(publishSay) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发说说" style:UIBarButtonItemStyleDone target:self action:@selector(publishSay)];
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    [[CommunityHelper shareCommuntiyHelper] getAllPostsWhenFinished:^{
        [self.tableView reloadData];
    }];
     [self setRefresh];
}
#pragma mark --代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 366;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [CommunityHelper shareCommuntiyHelper].postsArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //调用绘制cell方法
    if ([CommunityHelper shareCommuntiyHelper].postsArr.count > 0) {
        NSInteger count = [CommunityHelper shareCommuntiyHelper].postsArr.count;
        cell.model = [CommunityHelper shareCommuntiyHelper].postsArr[count - 1-indexPath.row];
    }
    cell.myblock = ^(NSString *s,UIImage *umg){
//        [UMSocialSnsService presentSnsIconSheetView:self appKey:@"561e136567e58e113b00255f" shareText:s shareImage:umg shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,] delegate:nil];
    };
    return cell;
}

#pragma  mark -- button点击事件
- (void)publishSay{
    PublishSayController *pub = [PublishSayController new];
    [self showViewController:pub sender:nil];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger count = [CommunityHelper shareCommuntiyHelper].postsArr.count;
    CommunityDetailController *detail = [[CommunityDetailController alloc] initWithModle:[CommunityHelper shareCommuntiyHelper].postsArr[count - 1- indexPath.row]];
    [self setHidesBottomBarWhenPushed:YES];
    [self showViewController:detail sender:nil];
}

#pragma mark -- load lazy
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -35, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark  --上拉刷新
- (void)setRefresh{
    __weak UITableView * tableView = self.tableView;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [[CommunityHelper shareCommuntiyHelper] getAllPostsWhenFinished:^{
            [self.tableView  reloadData];
            [tableView.header endRefreshing];
        }];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.header.automaticallyChangeAlpha = YES;
}
@end
