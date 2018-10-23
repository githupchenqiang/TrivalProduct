//
//  LocationViewController.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/14.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CithHelp.h"
#import "CityModel.h"
#import "TableViewCell.h"
@interface LocationViewController ()<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CLLocationManager * locationManager;
    NSString * currentCity; //当前城市
}
@property (nonatomic,strong) CLLocationManager * locationManage;
@property (nonatomic,strong) CLLocation * location;
@property (nonatomic,strong)IBOutlet UILabel * alabel;
@property (nonatomic,strong)IBOutlet UITableView * tableView;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.hidesBottomBarWhenPushed = YES;
    self.alabel.text = _CityName;
    [self setlocationServices];//设置定位信息
    [[CithHelp shareCityData] requestAllNewsWithFinish:^{
        [self.tableView reloadData];
    }];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
      
    }
    return self;
}
#pragma mark --tableView的数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [CithHelp shareCityData].Sarray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[CithHelp shareCityData].Ndict[[CithHelp shareCityData].Sarray[section]] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell * cell = [TableViewCell cellWithtableView:tableView];
    CityModel * cModel =[[CithHelp shareCityData] itemWithNSindexth:indexPath];
    cell.Model = cModel;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==1)return @"全部城市";
    return nil;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityModel * cmodel = [CityModel new];
    cmodel =[CithHelp shareCityData].Ndict[[CithHelp shareCityData].Sarray[indexPath.section]][indexPath.row];
    self.alabel.text = cmodel.cityName;
    self.myblock(self.alabel.text);
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark   --设置定位
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

-(void)ToGetPlace{
    
    return;
    
    CLGeocoder * clGeoCoder = [[CLGeocoder alloc] init];
    [clGeoCoder reverseGeocodeLocation:self.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(placemarks.count>0){
            CLPlacemark * placemark = [placemarks objectAtIndex:0];
            //将获取信息显示在label上
            self.alabel.text = placemark.locality;
            //
            NSString * city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSLog(@"city = %@", city);
        }else if (error == nil && [placemarks count] == 0){
            NSLog(@"No results were returned.");
        }else if (error != nil){
            NSLog(@"An error occurred = %@", error);
        }
    }];
    self.myblock(self.alabel.text);
    [self.locationManage stopUpdatingLocation];
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
            
            //  Country(国家)  State(省)  City（市）
            NSLog(@"#####%@",address);
            
            NSLog(@"%@", [address objectForKey:@"Country"]);
            
            NSLog(@"%@", [address objectForKey:@"State"]);
            
            NSLog(@"%@", [address objectForKey:@"City"]);
            _alabel.text = [[address objectForKey:@"Country"] stringByAppendingString:[address objectForKey:@"City"]];
            
        }
        
    }];

}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code] ==kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if([error code]==kCLErrorLocationUnknown){
        NSLog(@"无法获取位置信息");
    }
}


#pragma mark  --懒加载

-(CLLocationManager *)locationManage{
    if (_locationManage ==nil) {
        _locationManage = [[CLLocationManager alloc]init];
    }
    return _locationManage;
}
-(UITableView *)tableView{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight =30;
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
