//
//  HomeViewController.m
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
/**
 *  首页根视图控制器.
 *
 */
#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "NearByViewController.h"
#import "HomeHelper.h"
#import "HomeBanner.h"
#import "SuitCollectionCell.h"
#import "SuitplaceViewController.h"
#import "LoginController.h"
#import "MineController.h"
#import "LocationViewController.h"
#import "PublicSource.h"

#import "SearchViewController.h"
#import "NearByHelper.h"
#import "NearByCell.h"
#import "NearByDetailViewController.h"
#import <MJRefresh.h>
#import "CitysViewController.h"
#import "MBProgressHUD.h"
#import <MapKit/MapKit.h>
#import "UIView+HUD.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) SDCycleScrollView *sdcycleScrollView;   //轮播图
@property (nonatomic,strong) UIButton *nearbyButton;                 //周边游
@property (nonatomic,strong) UIButton *lookTravelButton;             //看游记
//@property (nonatomic,strong) UIBarButtonItem * leftButton;   //左button
@property (nonatomic,strong) UIBarButtonItem * rigthButton;  //右button
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSString *cityname;
@property (nonatomic,strong) NSString *locatCity;
@property (nonatomic,strong)NSMutableArray              *DataArray;
@property (nonatomic,assign)NSInteger                   Page;
@property (nonatomic,assign)BOOL                        LoadMore;
@property (nonatomic,strong)MBProgressHUD               *hud;
@property (nonatomic,strong) CLLocationManager * locationManage;
@property (nonatomic,strong) CLLocation * location;
@property (nonatomic,strong)NSString                    *City;
@property (nonatomic,strong) UILabel                    *Citylabel;
@property (nonatomic,strong)UIView                      *sview;
@property (nonatomic,strong)UIView                      *Aview;
@end

@implementation HomeViewController
/*- (instancetype)init
{
    self = [super init];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(90, 130);
        flowLayout.sectionInset =  UIEdgeInsetsMake(8, 15, 8, 15);
        flowLayout.headerReferenceSize = CGSizeMake(0, 280);
        
        
       
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight- [PublicSource TabbarHeight]) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        
        //轮播图
        self.sdcycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
        _sdcycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _sdcycleScrollView.dotColor = [UIColor yellowColor];
        _sdcycleScrollView.placeholderImage = [UIImage imageNamed:@"place"];

        _nearbyButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_nearbyButton setTitle:@"周边游" forState:UIControlStateNormal];
        [_nearbyButton  setImage:[UIImage imageNamed:@"nearByPlay"] forState:UIControlStateNormal];
        _nearbyButton.frame = CGRectMake(30, 190 , 100, 40);
        [_nearbyButton addTarget:self action:@selector(goNearbyPage) forControlEvents:UIControlEventTouchUpInside];
        
        _lookTravelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_lookTravelButton setTitle:@"看游记" forState:UIControlStateNormal];
        [_lookTravelButton setImage:[UIImage imageNamed:@"lookNote"] forState:UIControlStateNormal];
        _lookTravelButton.frame = CGRectMake(kScreenWidth - 130, 190, 100, 40);
        [_lookTravelButton  addTarget:self action:@selector(travelNotesPageForDetails) forControlEvents:UIControlEventTouchUpInside];
     }
    return self;
}*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setlocationServices];
        self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _sview.hidden = NO;
    _Aview.hidden = NO;
    self.locatCity = @"北京";
    [[NearByHelper shareNearByHelper] requestNearByPlace:self.locatCity WithFinised:^{
        [self.tableView reloadData];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _sview.hidden = YES;
    _Aview.hidden = YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _Page = 1;
    _cityname = @"北京";
    _DataArray = [NSMutableArray array];
    //增加监听者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ListenToInform:) name:@"tongzhi1" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ListenToInform:) name:@"weiboUser" object:nil];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NearByCell" bundle:nil] forCellReuseIdentifier:@"nearByCell"];
   /* [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SuitCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"suitCollectionCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [[HomeHelper sharedHomeHelper] requestBannersWithFinished:^{
        NSMutableArray *arr = [NSMutableArray array];
        for (HomeBanner *hb in [HomeHelper sharedHomeHelper].bannersArr) {
            [arr addObject:hb.img_url];
        }
        
        if (arr.count == 0) {
            [arr addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539591350005&di=efca350dc19b5d3f5d3c53b5942830d3&imgtype=0&src=http%3A%2F%2Fimg1.qunarzz.com%2Ftravel%2Fpoi%2F1409%2F29%2F65319f3636c83a2cffffffffc8d65eac.jpg_r_1024x683x95_87e4d30c.jpg"];
        }
        
        _sdcycleScrollView.imageURLStringsGroup = arr;
    }];
    
    [[HomeHelper sharedHomeHelper] requestTravelPlaceWithFinished:^{
        [self.collectionView reloadData];
    }];*/
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _sview = [[UIView alloc]initWithFrame:CGRectMake(0, [PublicSource NavigationBarHeight] - 40, 60, 44)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 10, 20, 20);
        [button setImage:[UIImage imageNamed:@"locaiImg"] forState:UIControlStateNormal];
        [_sview addSubview:button];
        _Citylabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 40, 44)];
        _Citylabel.font = [UIFont systemFontOfSize:11];
        _Citylabel.text = @"北京市";
        _Citylabel.numberOfLines = 2;
        _Citylabel.textAlignment = NSTextAlignmentCenter;
        [_sview addSubview:_Citylabel];
       [self.navigationController.view addSubview:_sview];
    });

    
    
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
    
    
    
    
    [self LoadData];

    dispatch_async(dispatch_get_main_queue(), ^{
        _Aview = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 115,[PublicSource NavigationBarHeight] - 39, 250, 34)];
        _Aview.layer.masksToBounds = YES;
        _Aview.layer.cornerRadius = 17;
        _Aview.layer.borderColor = [UIColor grayColor].CGColor;
        _Aview.layer.borderWidth = 0.5;
        UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
        UIImageView  *SeachImage = [[UIImageView alloc]initWithFrame:CGRectMake(100, 7, 20, 20)];
        SeachImage.image = [UIImage imageNamed:@"搜索"];
        [_Aview addSubview:SeachImage];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(125, 7, 100, 20)];
        label.text = @"搜索城市";
        label.textColor = [UIColor brownColor];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentLeft;
        [_Aview addSubview:label];
        [_Aview addGestureRecognizer:Tap];
        [self.navigationController.view addSubview:_Aview];
    });
    
   
    dispatch_async(dispatch_get_main_queue(), ^{
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.activityIndicatorColor = [UIColor colorWithRed:246/255.0 green:8/255.0 blue:142/255.0 alpha:1];
        _hud.mode = MBProgressHUDModeIndeterminate;
        _hud.minSize = CGSizeMake(50, 50);
        _hud.labelText = @"加载默认城市数据...";
        [_hud show:YES];
    });
}

-(void)setlocationServices{
    if ([CLLocationManager locationServicesEnabled]) {//判断定位操作是否被允许
        
        self.locationManage = [[CLLocationManager alloc] init];
        
        self.locationManage.delegate = self;//遵循代理
        
        self.locationManage.desiredAccuracy = kCLLocationAccuracyBest;
        
        self.locationManage.distanceFilter = 10.0f;
        
        [_locationManage requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8以上版本定位需要）
        
        [self.locationManage startUpdatingLocation];//开始定位
        
    }else{//不能定位用户的位置的情况再次进行判断，并给与用户提示
        
        //1.提醒用户检查当前的网络状况
        
        //2.提醒用户打开定位开关
        
    }
}

#pragma mark   --实现定位的代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //当前所在城市的坐标值
    CLLocation *currLocation = [locations lastObject];
    
    NSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *address = [placemark addressDictionary];
            _Citylabel.text = [address objectForKey:@"City"];
        }
    }];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code] ==kCLErrorDenied) {
        NSLog(@"访问被拒绝");
           [self.view showSuccess:@"定位授权被拒"];
    }
    if([error code]==kCLErrorLocationUnknown){
        NSLog(@"无法获取位置信息");
         [self.view showSuccess:@"无法获取位置信息"];
    }
}


- (void)LoadData{
    [[NearByHelper shareNearByHelper]requestNearByPlace:_cityname page:_Page WithFinised:^(id responseObject) {
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


- (void)TapAction:(UIGestureRecognizer *)gesture{
    CitysViewController *searchVC = [[CitysViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark --tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _DataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NearByCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nearByCell" forIndexPath:indexPath];
    cell.item = _DataArray[indexPath.row];
    return cell;
}
#pragma mark --tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NearByDetailViewController *nearDetailVC = [NearByDetailViewController new];
    nearDetailVC.modell = _DataArray[indexPath.row];
    nearDetailVC.isfave = NO;
    [self showViewController:nearDetailVC sender:nil];
}


#pragma mark ==懒加载==
-(void)leftButton{
    
}

-(UIBarButtonItem *)rigthButton{
    if (_rigthButton ==nil) {
        _rigthButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"outLogin"] style:  UIBarButtonItemStylePlain target:self action:@selector(RigthTriggeringMethod:)];
        self.navigationItem.rightBarButtonItem =_rigthButton;
    }
    return _rigthButton;
}

#pragma mark --UI控件触发方法
-(void)travelNotesPageForDetails{
    TravelLiteratureController * trave = [TravelLiteratureController new];
    [self.navigationController  pushViewController:trave animated:YES];
}
-(void)LeftTriggeringMethod:(UIBarButtonItem *)aBarbutton{
    LocationViewController * locationVC = [LocationViewController new];
    __weak HomeViewController *weakSelf = self;
    locationVC.myblock = ^(NSString *cityName){
        weakSelf.cityname = cityName;
    };
    locationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:locationVC animated:YES];
}

-(void)RigthTriggeringMethod:(UIBarButtonItem *)bBarbutton{
      LoginController * logVC = [LoginController new];
      [self.navigationController  presentViewController:logVC animated:YES completion:nil];
}
//去 "周边游页面"
- (void)goNearbyPage{
    NearByViewController *neVC = [[NearByViewController alloc] init];
    neVC.locatCity = @"北京";
    [self showViewController:neVC sender:nil];
}
#pragma mark -- collection dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [HomeHelper sharedHomeHelper].suitArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SuitCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"suitCollectionCell" forIndexPath:indexPath];
    cell.item = [HomeHelper sharedHomeHelper].suitArr[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        [header addSubview:self.sdcycleScrollView];
        [header addSubview:self.nearbyButton];
        [header addSubview:self.lookTravelButton];
        UILabel *suitPlace = [[UILabel alloc]initWithFrame:CGRectMake(0, 240, kScreenWidth, 30)];
        suitPlace.text =@"最适合10月份去旅行的地方" ;
        suitPlace.textAlignment =1;
        suitPlace.textColor = [UIColor lightGrayColor];
        suitPlace.font = [UIFont fontWithName:@"Helvetica"  size:15];
        suitPlace.backgroundColor = [UIColor clearColor];
        [header addSubview:suitPlace];
        return header;
    }else{
        NSLog(@"尾");
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        return footer;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SuitplaceViewController *suitplaceVC = [[SuitplaceViewController alloc]init];
    SuitPlace *su = [HomeHelper sharedHomeHelper].suitArr[indexPath.row];
    suitplaceVC.urlStr = su.jump_url;
    [self showViewController:suitplaceVC sender:nil];
    
}
#pragma mark  --通知的方法
-(void)ListenToInform:(NSNotification *)noteinfo{
    self.rigthButton.image =nil;
    [self.rigthButton setTitle:noteinfo.userInfo[@"userImage"]];
    [self.rigthButton setTintColor:[UIColor whiteColor]];
}
-(void)ListenToWeiboInform:(NSNotification *)weiboInfo{
    self.rigthButton.image =nil;
    [self.rigthButton setTitle:weiboInfo.userInfo[@"userImg"]];
    [self.rigthButton setTintColor:[UIColor whiteColor]];
}
@end
