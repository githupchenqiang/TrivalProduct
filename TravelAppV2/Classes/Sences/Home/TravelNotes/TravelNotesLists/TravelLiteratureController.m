//
//  TravelLiteratureController.m
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "TravelLiteratureController.h"
#import <MJRefresh.h>

@interface TravelLiteratureController ()
@property (nonatomic,assign) NSInteger  page;
@end

@implementation TravelLiteratureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [[TravelsNoteHelp shareTravelsNoteData] requestAllNewsWithFinish:^{
    [self.tableView  reloadData];
    }];
    [self  setRefresh];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [TravelsNoteHelp shareTravelsNoteData].Narray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TravelsCell * cell = [TravelsCell  cellWithTabelView:tableView];
    TravelsModel * model = [[TravelsNoteHelp shareTravelsNoteData]itemWithIndex:indexPath.row];
    cell.travel = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TravelNotesDetails * traveD = [TravelNotesDetails shareTravelNotesListData];
    [TravelNoteHelp shareTravelNoteDetailData].TNid = ((TravelsModel *)[[TravelsNoteHelp shareTravelsNoteData]itemWithIndex:indexPath.row]).TDid;
    [self.navigationController  pushViewController:traveD animated:YES];
    }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

#pragma mark  --上拉刷新,下拉加载--
- (void)setRefresh{
    __weak UITableView * tableView = self.tableView;
self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    [TravelsNoteHelp shareTravelsNoteData].isRefresh =YES;
    [[TravelsNoteHelp shareTravelsNoteData] requestAllNewsWithFinish:^{
        [self.tableView  reloadData];
        [tableView.header endRefreshing];
    }];
}];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.header.automaticallyChangeAlpha = YES;
    // 上拉刷新
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
              [TravelsNoteHelp shareTravelsNoteData].isRefresh =NO;
            [[TravelsNoteHelp shareTravelsNoteData] requestAllNewsWithFinish:^{
                [self.tableView  reloadData];
                [tableView.header endRefreshing];
            }];
            // 结束刷新
            [tableView.footer endRefreshing];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
//    [self setRefresh];
}
@end
