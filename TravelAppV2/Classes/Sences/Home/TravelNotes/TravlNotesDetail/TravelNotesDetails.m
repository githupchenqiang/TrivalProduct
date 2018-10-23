//
//  TravelNotesDetails.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/8.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "TravelNotesDetails.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS


@interface TravelNotesDetails ()

@end

@implementation TravelNotesDetails
+(TravelNotesDetails *)shareTravelNotesListData{
    static  TravelNotesDetails  * travelsNote =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        travelsNote= [TravelNotesDetails new];
    });
    return travelsNote;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    UIBarButtonItem * barbutton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = barbutton;
}
#pragma  mark  ==dataSource方法==
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [TravelNoteHelp shareTravelNoteDetailData].SNarray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [TravelNoteHelp shareTravelNoteDetailData].Narray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelDetailCell * cell = [TravelDetailCell cellWithTableView:tableView];
    TravelNotesFrame * f =[[TravelNotesFrame alloc]init];
    f.traveNotesModel = [[TravelNoteHelp shareTravelNoteDetailData] itemWithIndex:indexPath.row];
    cell.travelNoteFrame = f;
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * alabel = [UILabel new];
    alabel.font = [UIFont systemFontOfSize:14];
    alabel.text = [NSString stringWithFormat:@"第%ld天  %@",section+1,[TravelNoteHelp shareTravelNoteDetailData].NDNarry[section]];
    return alabel;
 }

#pragma makr   ==delegate方法==
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TravelNotesFrame * f =[[TravelNotesFrame alloc]init];
    f.traveNotesModel =[[TravelNoteHelp shareTravelNoteDetailData] itemWithIndex:indexPath.row];
    f.traveNotesModel.length = self.view.frame.size.width;
    return f.cellHegth;
}
#pragma mark   --触发方法
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [[TravelNoteHelp shareTravelNoteDetailData] requestAllNewsWithFinish:^{
    [self.tableView  reloadData];
    }];
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.delegate  ModifyTheInsideOfTheSingLetonArray];
}
@end
