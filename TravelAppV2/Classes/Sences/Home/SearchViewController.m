//
//  SearchViewController.m
//  TravelAppV2
//
//  Created by 陈强 on 2018/10/21.
//  Copyright © 2018年 蓝鸥. All rights reserved.
//

#import "SearchViewController.h"
#import "NearByCell.h"
#import "NearByHelper.h"
#import <MJRefresh.h>
#import "NearByDetailViewController.h"
#import "MBProgressHUD.h"
#import "UIView+HUD.h"
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView         *tableView;
@property (nonatomic,strong)NSMutableArray      *DataArray;
@property (nonatomic,assign)NSInteger           Page;
@property (nonatomic,assign)BOOL                LoadMore;
@property (nonatomic,strong)MBProgressHUD       *hud;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _Page = 1;
 
    [self  LoadData];
 
    self.DataArray = [NSMutableArray array];
    self.title = _CityName;
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, self.view.frame.size.height) style:UITableViewStylePlain];
     [_tableView registerNib:[UINib nibWithNibName:@"NearByCell" bundle:nil] forCellReuseIdentifier:@"nearBy"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _Page = 1;
        _LoadMore = NO;
        [self  LoadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _Page ++;
        _LoadMore = YES;
        [self  LoadData];
    }];
    [self.tableView.mj_header beginRefreshingCompletionBlock];
    dispatch_async(dispatch_get_main_queue(), ^{
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.activityIndicatorColor = [UIColor colorWithRed:246/255.0 green:8/255.0 blue:142/255.0 alpha:1];
        _hud.mode = MBProgressHUDModeIndeterminate;
        _hud.minSize = CGSizeMake(50, 50);
        _hud.labelText = @"Loading...";
        [_hud show:YES];
    });
}


- (void)LoadData{
    [[NearByHelper shareNearByHelper]requestNearByPlace:_CityName page:_Page WithFinised:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"items"];
        
        if (_DataArray != nil) {
            if (!_LoadMore) {
                [self.DataArray removeAllObjects];
            }
        }else
        {
            self.DataArray = [NSMutableArray array];
        }
        for (NSDictionary *dic in dataArr) {
            CityItem *ci = [CityItem new];
            [ci setValuesForKeysWithDictionary:dic];
            [_DataArray addObject:ci];
        }
        [_hud hide:YES];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } fail:^{
        [_hud hide:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.view showSuccess:@"获取数据有误"];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _DataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearByCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nearBy" forIndexPath:indexPath];
     cell.item = _DataArray[indexPath.row];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearByDetailViewController *nearDetailVC = [NearByDetailViewController new];
    nearDetailVC.modell = _DataArray[indexPath.row];
    nearDetailVC.isfave = NO;
    [self showViewController:nearDetailVC sender:nil];
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
