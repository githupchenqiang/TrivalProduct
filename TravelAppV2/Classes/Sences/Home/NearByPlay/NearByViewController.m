//
//  NearByViewController.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
/**
 *  根据 地区定位 搜索周边的 景点
 *
 */

#import "NearByViewController.h"
#import "NearByCell.h"
#import "NearByDetailViewController.h"
#import "NearByHelper.h"

@interface NearByViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation NearByViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
            [self.view addSubview:_tableView];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NearByHelper shareNearByHelper] requestNearByPlace:self.locatCity WithFinised:^{
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NearByCell" bundle:nil] forCellReuseIdentifier:@"nearByCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
}

#pragma mark --tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NearByCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nearByCell" forIndexPath:indexPath];
    cell.item = [NearByHelper shareNearByHelper].nearByArr[indexPath.row];
    return cell;
}
#pragma mark --tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NearByDetailViewController *nearDetailVC = [NearByDetailViewController new];
    nearDetailVC.modell = [NearByHelper shareNearByHelper].nearByArr[indexPath.row];
    [self showViewController:nearDetailVC sender:nil];
}

@end
