//
//  ThemePlayViewController.m
//  TravelAppV1
//
//  Created by chenqiang on 15/10/7.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "ThemePlayViewController.h"
#import "SubjectCell.h"
#import "ThemeCell.h"
#import "HeaderView.h"
#import "CCHexagonFlowLayout.h"
#import "ThemeHelp.h"
#import "SubjectDetail.h"
#import "ThemeDetail.h"

@interface ThemePlayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CCHexagonDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;

@end

@implementation ThemePlayViewController
 

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置collection布局layout
    CCHexagonFlowLayout *layout = [[CCHexagonFlowLayout alloc] init];
//    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 8.0f;
    layout.minimumLineSpacing = 10.0f;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 40.0f,0, 20.0f);
    layout.itemSize = CGSizeMake(self.view.frame.size.width * 0.37, self.view.frame.size.height * 0.27);
    layout.delegate = self;
    layout.headerReferenceSize = HeaderView_SIZE(layout.scrollDirection);
    layout.gap = 80.0f;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor =[UIColor whiteColor];

    //代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"SubjectCell" bundle:nil] forCellWithReuseIdentifier:@"subjectCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ThemeCell" bundle:nil] forCellWithReuseIdentifier:@"themeCell"];
    
    //注册头
    [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.collectionView];
    
    [[ThemeHelp shareHandle]requestSubjectWithSub:^{
        [self.collectionView reloadData];
    }];
    [[ThemeHelp shareHandle]fecthThemeWithBlock:^{
        [self.collectionView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UICollectionViewDataSource --
//划分section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   return 2;
}
//返回item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return [ThemeHelp shareHandle].subjectArr.count;
    }else{
        return [ThemeHelp shareHandle].themeArr.count;
    }
}
//设置分区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        HeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor cyanColor];
        if (indexPath.section == 0) {
            header.title4Label.text = @"发现下一站";
            header.title4Label.textColor = [UIColor grayColor];
        }else{
            header.title4Label.text = @"花样撒野";
            header.title4Label.textColor = [UIColor grayColor];
        }
        return header;
        
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footer.backgroundColor = [UIColor magentaColor];
        return footer;
    }
}
//根据不同需要设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return CGSizeMake(self.view.frame.size.width * 0.586, self.view.frame.size.height * 0.2);
    }else if(indexPath.section == 0 && indexPath.row == 1){
        return CGSizeMake(self.view.frame.size.width * 0.624, self.view.frame.size.height * 0.2);
    }else if(indexPath.section == 0 && indexPath.row == 2){
        return CGSizeMake(self.view.frame.size.width * 0.586, self.view.frame.size.height * 0.2);
    }else{
        return CGSizeMake(120,160);
    }
    
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SubjectCell *subCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"subjectCell" forIndexPath:indexPath];
        subCell.item = [ThemeHelp shareHandle].subjectArr[indexPath.row];
        subCell.layer.shadowColor  =  [UIColor grayColor].CGColor;
        subCell.layer.shadowOpacity = 1.0;
        subCell.layer.shadowRadius = 3.0;
        subCell.layer.shadowOffset = CGSizeMake(0,4);
       return subCell;
    }else{
        ThemeCell *themeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"themeCell" forIndexPath:indexPath];
        themeCell.item = [ThemeHelp shareHandle].themeArr[indexPath.row];
        themeCell.layer.shadowColor  =  [UIColor grayColor].CGColor;
        themeCell.layer.shadowOpacity = 1.0;
        themeCell.layer.shadowRadius = 3.0;
        themeCell.layer.shadowOffset = CGSizeMake(0,4);
        return themeCell;
    }
    
}

//cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SubjectDetail *detailVC = [SubjectDetail new];
        detailVC.subItem = [ThemeHelp shareHandle].subjectArr[indexPath.row];
        [self showViewController:detailVC sender:detailVC.subItem];
    }else{
        ThemeDetail *themeVC = [ThemeDetail new];
        themeVC.themeItem = [ThemeHelp shareHandle].themeArr[indexPath.row];
        [self showViewController:themeVC sender:themeVC.themeItem];
    }
}


@end
