//
//  CommunityDetailController.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "CommunityDetailController.h"
#import "CommunityDetailCell.h"
#import "CommunityHelper.h"
#import "LoginController.h"
@interface CommunityDetailController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)UITextField *commentTextField;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UIView *detailView;
@property (nonatomic,strong)UIImageView *img4name;
@property (nonatomic,strong)UILabel *lab4name;
@property (nonatomic,strong)UILabel *lab4place;
@property (nonatomic,strong)UILabel *lab4date;
@property (nonatomic,strong)UIImageView *img4spot;
@property (nonatomic,strong)UIButton *commitButton;
@property (nonatomic,strong) UILabel *contentLab;

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation CommunityDetailController


- (instancetype)initWithModle:(PostModel *)model{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self drawView];
        self.tableView.tableHeaderView = self.detailView;
        self.item = model;
        [[CommunityHelper shareCommuntiyHelper] getAllCommentByPostId:_item.objectId withFinished:^{
            self.dataArr = [NSMutableArray arrayWithArray:[CommunityHelper shareCommuntiyHelper].commentsArr] ;
            [self.tableView reloadData];
        }];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.commentTextField.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CommunityDetailCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
#pragma mark-----代理方法----------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommunityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.dataArr.count > 0 ) {
        NSInteger count = self.dataArr.count;
        cell.item = self.dataArr[count- indexPath.row-1];
    }
    cell.userInteractionEnabled = NO;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.commentTextField resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)setItem:(PostModel *)item{
    if(_item != item){
        _item = item;
    }
    [self.img4name sd_setImageWithURL:[NSURL URLWithString:item.userImgURL] placeholderImage:[UIImage imageNamed:@"user-64"]];
    self.lab4name.text = item.byUsername;
    //    self.lab4place.text = @"八达岭长城";
    self.lab4date.text = item.createdAt;
    self.lab4date.font = [UIFont systemFontOfSize:15];
    [self.img4spot sd_setImageWithURL:[NSURL URLWithString:item.contentImgURL]];
    self.contentLab.text = item.content;
}

- (void)commitComment {
    
    [self.commentTextField resignFirstResponder];
    //未登陆
    if ([AVUser currentUser] == nil) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"未登录!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cencel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *confirm =  [UIAlertAction actionWithTitle:@"去登陆?" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *  action) {
            //去登陆
            LoginController *lg = [[LoginController alloc] init];
            lg.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self showDetailViewController:lg sender:nil];
        }];
        [alertVC addAction:cencel];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    AVObject *post = [AVObject objectWithoutDataWithClassName:@"Post" objectId:self.item.objectId];
    AVObject *obj = [AVObject objectWithClassName:@"Comment"];
    obj[@"content"] = self.commentTextField.text;
    obj[@"fromUser"] = [AVUser currentUser];
    obj[@"toPost"] = post;
    

    [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            CommentModel *cm = [[CommentModel alloc] initWithAVObject:obj];
            [self.dataArr addObject:cm];
            [self.tableView reloadData];
            
        }else{
            NSLog(@"失败");
        }
    }];
    self.commentTextField.text = @"";
}
#pragma mark-------textField代理方法-------------
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
            [UITableView animateWithDuration:0.2 animations:^{
            CGRect frame = self.commentTextField.frame;
                int offset = frame.origin.y -10 - (self.view.frame.size.height- 243);
                if (offset > 0) {
                    self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
                    [UIView commitAnimations];
                }
            }];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
     self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.commentTextField resignFirstResponder];
    return YES;
}

#pragma mark -- load lazy
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-65) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    return _tableView;
}
- (UITextField *)commentTextField {
    if (_commentTextField == nil) {
        _commentTextField =  [[UITextField alloc]initWithFrame:CGRectMake(0, kScreenHeight-105, kScreenWidth-80, 40)];
        //_commentTextField.backgroundColor = [UIColor redColor];
        _commentTextField.borderStyle = UITextBorderStyleRoundedRect;
        _commentTextField.placeholder = @"我也说几句......";
        [self.view addSubview:_commentTextField];
    }
    return _commentTextField;
}

- (void)drawView {
    self.detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 314)];
    self.detailView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.detailView];
    self.img4name = [[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 45, 45)];
    self.img4name.image = [UIImage imageNamed:@"si"];
    [self.detailView addSubview:self.img4name];
    
    self.lab4name = [[UILabel alloc]initWithFrame:CGRectMake(70, 15, 75, 21)];
    self.lab4name.text = @"  ";
    _lab4name.textColor = [UIColor colorWithRed:40 / 255.0 green:123 / 255.0 blue:1.0 alpha:1];
    [self.detailView addSubview:self.lab4name];
    
    self.lab4place = [[UILabel alloc]initWithFrame:CGRectMake(70, 40, 139, 21)];
    self.lab4place.text = @"北京";
    self.lab4place.font = [UIFont systemFontOfSize:15];
    [self.detailView addSubview:self.lab4place];
    
    self.lab4date = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-120, 30, 100, 21)];
    self.lab4date.text = @"";
    self.lab4date.font = [UIFont systemFontOfSize:15];
    self.lab4date.textColor = [UIColor lightGrayColor];
    [self.detailView addSubview:self.lab4date];
    
    self.img4spot = [[UIImageView alloc]initWithFrame:CGRectMake(5, 70, kScreenWidth-10, 190)];
    self.img4spot.backgroundColor = [UIColor orangeColor];
    self.img4spot.image = [UIImage imageNamed:@"6"];
    [self.detailView addSubview:self.img4spot];
    
    self.contentLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 277, self.view.frame.size.width - 10, 30)];
    [self.detailView addSubview:_contentLab];
    self.commitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.commitButton.frame = CGRectMake(kScreenWidth-81, kScreenHeight-105, 81, 40);
    [self.commitButton setTitle:@"评论" forState:UIControlStateNormal];
    self.commitButton.backgroundColor = [UIColor lightGrayColor];
    
    [self.commitButton addTarget:self action:@selector(commitComment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commitButton];
}

@end
