//
//  MineController.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/10.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "MineController.h"
#import "RKCardView.h"
#import "LoginController.h"
#import "RegisterController.h"
#import "UserTableViewCell.h"
#import "PublicSource.h"
#import "FaveViewController.h"
#import "MINAboutViewController.h"

#define BUFFERX 10
#define BUFFERY 60

@interface MineController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) RKCardView *cardView;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *logOut;
@property (nonatomic,strong)UITableView     *table;
@property (nonatomic,strong)NSArray     *mutArray;
@property (nonatomic,strong)NSArray     *NameArray;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dreaw];
    [self drawLabel];
    
    //登陆成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatus:) name:@"登陆成功" object:nil];
    _mutArray = @[@"收 藏",@"关于我们"];
    _NameArray = @[@"我的收藏",@"关于我们"];
    [self DrawTableView];
    
    
}

- (void)DrawTableView{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0,_cardView.frame.size.height + [PublicSource NavigationBarHeight], self.view.frame.size.width, 35 * _mutArray.count) style:(UITableViewStylePlain)];
    [_table registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserCell"];
    _table.scrollEnabled = NO;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _NameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    cell.Image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_mutArray[indexPath.row]]];
    cell.Name.text = [NSString stringWithFormat:@"%@",_NameArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        FaveViewController *fav = [[FaveViewController alloc]init];
        [self.navigationController pushViewController:fav animated:YES];
    }else if (indexPath.row == 1)
    {
        MINAboutViewController *fav = [[MINAboutViewController alloc]init];
        [self.navigationController pushViewController:fav animated:YES];
    }
    
}



- (void)changeStatus:(NSNotification *)no{
    AVUser *user = no.userInfo[@"information"];
    [self changeInfomationOfUser:user];
}

//改变用户信息;
- (void)changeInfomationOfUser:(AVUser *)user{
    if(user != nil){
        _loginBtn.hidden = YES;
        _logOut.hidden = NO;
        _cardView.titleLabel.text = user[@"nickname"];
        if(user[@"Avatar"] != nil){
            AVFile *imgFile = [AVUser currentUser][@"Avatar"];
            _cardView.profileImageView.image = [UIImage imageWithData:[imgFile getData]];
            _cardView.coverImageView.image = [UIImage imageWithData:[imgFile getData]];
        }
    }else{
         [_loginBtn setTitle:@"请登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _loginBtn.hidden = NO;
        _logOut.hidden = YES;
    }
}
- (void)dreaw{
    //卡片
    self.cardView= [[RKCardView alloc]initWithFrame:CGRectMake(BUFFERX, 64, self.view.frame.size.width-2*BUFFERX,200)];
    [_cardView addShadow];
    _cardView.coverImageView.image = [UIImage imageNamed:@"bj.png"];
    _cardView.profileImageView.image = [UIImage imageNamed:@"user-64.png"];
    _cardView.titleLabel.text = @"亲,你还没登陆呢";
    _cardView.titleLabel.font = [UIFont systemFontOfSize:15];
    _cardView.profileImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_cardView.profileImageView addGestureRecognizer:tap];
    //登陆按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(10, 150, 60, 25);
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"dl.png"] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(jumpToLogin) forControlEvents:UIControlEventTouchUpInside];
    
    //登出
    self.logOut = [UIButton buttonWithType:UIButtonTypeCustom];
    _logOut.frame = CGRectMake((self.view.frame.size.width-2*BUFFERX) * 0.77, (self.view.frame.size.height-2*BUFFERY) * 0.44, 60, 25);
    [_logOut setBackgroundImage:[UIImage imageNamed:@"dl.png"] forState:UIControlStateNormal];
    [_logOut setTitle:@"注销" forState:UIControlStateNormal];
    [_logOut addTarget:self action:@selector(outOflogin) forControlEvents:UIControlEventTouchUpInside];
    [_cardView addSubview:_logOut];
    
    [self changeInfomationOfUser:[AVUser currentUser]];

    
//    UILabel *Label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height-2*BUFFERY) * 0.5,self.view.frame.size.width-2*BUFFERX, 2)];
//    Label1.layer.borderWidth = 2;
//    Label1.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    [_cardView addSubview:Label1];
//    UILabel *Label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height-2*BUFFERY) * 0.6,self.view.frame.size.width-2*BUFFERX, 2)];
//    Label2.layer.borderWidth = 2;
//    Label2.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    [_cardView addSubview:Label2];
//    UILabel *Label3 = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.height-2*BUFFERY) * 0.32, (self.view.frame.size.height-2*BUFFERY) * 0.5,2, (self.view.frame.size.height-2*BUFFERY) * 0.1)];
//    Label3.layer.borderWidth = 2;
//    Label3.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    [_cardView addSubview:Label3];
    
    [_cardView addSubview:_loginBtn];
    [self.view addSubview:_cardView];
    
}

#pragma mark --tap手势
- (void)tapAction{
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
    pick.delegate = self;
    pick.allowsEditing = YES;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera; //默认 是相机
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    pick.sourceType = sourceType;
    [self presentViewController:pick animated:YES completion:nil];
}


#pragma mark Camera View Delegate Methods
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    _cardView.profileImageView.image = img;
    //在此处将 头像保存到 服务器
    NSData *imageData = UIImagePNGRepresentation(_cardView.profileImageView.image);
    AVFile *imageFile = [AVFile fileWithName:@"image.png" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            [[AVUser currentUser] setObject:imageFile forKey:@"Avatar"];
            [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                }else{
                    NSLog(@"头像保存失败%@",error);
                }
            }];
        }else{
        }
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --button跳转事件
- (void)jumpToLogin{
    LoginController *loginVC = [[LoginController alloc]initWithNibName:@"LoginController" bundle:nil];
    loginVC.modalTransitionStyle =UIModalTransitionStyleCrossDissolve;
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)outOflogin{
    [AVUser logOut];
    _cardView.titleLabel.text = @"亲,你还没登陆呢";
    _cardView.titleLabel.font = [UIFont systemFontOfSize:15];
    _cardView.profileImageView.image = [UIImage imageNamed:@"user-64.png"];
    _logOut.hidden = YES;
    _loginBtn.hidden = NO;
    [_loginBtn setTitle:@"请登录" forState:UIControlStateNormal];
}
- (void)drawLabel{
    
    
    
    
}
//视图将要消失时发送通知.
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhi1" object:self userInfo:@{@"userImage":self.cardView.titleLabel.text}];
}
@end
