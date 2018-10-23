//
//  FaveViewController.m
//  TravelAppV2
//
//  Created by AmpleSky on 2018/10/23.
//  Copyright © 2018年 蓝鸥. All rights reserved.
//
#import "FaveViewController.h"
#import "NearByCell.h"
#import "FMDBSource.h"
#import "UIView+HUD.h"
#import "FaveDetailViewController.h"
#import "FMDBSource.h"

@interface FaveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray  *dataArray;
@end

@implementation FaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.001)];
    [_tableView registerNib:[UINib nibWithNibName:@"NearByCell" bundle:nil] forCellReuseIdentifier:@"nearByCell"];
    [self.view addSubview:self.tableView];
    
    
    BOOL result = [[FMDBSource DefaultDataSource]openDB];
    if (result) {
        NSArray *array = [[FMDBSource DefaultDataSource] SearchDataBse];
        _dataArray = [array mutableCopy];
        if (_dataArray.count == 0) {
            [self.view showMessage:@"您还没有收藏,快去收藏吧..."];
        }
        [_tableView reloadData];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearByCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nearByCell" forIndexPath:indexPath];
    cell.item = _dataArray[indexPath.row];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        CityItem *item = _dataArray[indexPath.row];
        [_dataArray removeObjectAtIndex:indexPath.row];
        if ([[FMDBSource DefaultDataSource]openDB]) {
            [[FMDBSource DefaultDataSource]delegateDatabasewith:item.productId];
        }
        
        
        [_tableView reloadData];
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FaveDetailViewController *nearDetailVC = [FaveDetailViewController new];
    nearDetailVC.modell = _dataArray[indexPath.row];
    
    [self showViewController:nearDetailVC sender:nil];
}


@end

