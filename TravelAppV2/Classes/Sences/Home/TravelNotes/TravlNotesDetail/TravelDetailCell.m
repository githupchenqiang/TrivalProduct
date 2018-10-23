//
//  TravelDetailCell.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/8.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "TravelDetailCell.h"
#define KWidth
@interface TravelDetailCell ()
@property (nonatomic,strong) UILabel * textTitle;
@property (nonatomic,strong) UIButton * iamgeView;
@property (nonatomic,strong) UIImageView * imageClock;
@property (nonatomic,strong) UIView * textView;
@property (nonatomic,strong) UIImageView * imageV;
@property (nonatomic,strong) UILabel * textAddress;
@property (nonatomic,strong) UILabel * textDate;
@property (nonatomic,strong) UIView * addressView;

@end
@implementation TravelDetailCell

+(TravelDetailCell *)cellWithTableView:(UITableView *)tableView{
    static  NSString * string =@"cel";
    TravelDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell = [[TravelDetailCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        cell.userInteractionEnabled = NO;
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mohu"]];
        }
       return cell;
}
#pragma makr   ==只需设置一次的控件放在初始化方法中==
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1.title
        UILabel * textTitle =[UILabel new];
        textTitle.numberOfLines=0;
        textTitle.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:textTitle];
        _textTitle = textTitle;
        //2.图片
        UIButton * iamgeView = [UIButton  buttonWithType:UIButtonTypeRoundedRect];
        iamgeView.layer.shadowColor = [UIColor blackColor].CGColor;
        iamgeView.layer.shadowOpacity = 1.0;
        iamgeView.layer.shadowRadius = 7.0;
        iamgeView.layer.shadowOffset = CGSizeMake(0, 4);
        
        [self.contentView addSubview:iamgeView];
        _iamgeView = iamgeView;
        //3.时钟
        UIImageView * imageClock =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"time.png"]];
        [self.contentView addSubview:imageClock];
        _imageClock = imageClock;
        //4.日期
        UILabel * textDate = [UILabel new];
        [self.contentView addSubview:textDate];
        textDate.font = [UIFont systemFontOfSize:14];
        _textDate = textDate;
        //5.包含address和定位View
        UIView * addressView = [UIView new];
        [self.contentView  addSubview:addressView];
        _addressView = addressView;
        //6.view上的图片
        UIImageView * imageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"locaiImg.png"]];
        [_addressView addSubview:imageV];
        _imageV = imageV;
        //7.address
        UILabel * textAddress = [UILabel new];
        textAddress.font = [UIFont systemFontOfSize:14];
        textAddress.numberOfLines = 0;
        [_addressView addSubview:textAddress];
        _textAddress = textAddress;
    }
    return self;
}
#pragma mark  ==重写模型的set方法==
-(void)setTravelNoteFrame:(TravelNotesFrame *)travelNoteFrame{
    _travelNoteFrame = travelNoteFrame;
    //设置详情页的数据
    [self  setData];
    //设置详情页子控件的frame(x,y,width,heigth);
    [self  settingSubviewFrame];
}
#pragma mark  ==设置详情页数据==
-(void)setData{
    TravelNotesModel * model = _travelNoteFrame.traveNotesModel;
    _textTitle.text = model.text;
    if (![model.photo_1600 isEqualToString:@""]) {
        _iamgeView.hidden =NO;
    [self.iamgeView sd_setBackgroundImageWithURL:[NSURL URLWithString:model.photo_1600] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"zhanwei.png"]];
    }else{
        _iamgeView.hidden =YES;
    }
    _textDate.text = model.local_time;
    if (model.poi[@"spot_region"] !=NO) {
        _textView.hidden = NO;
        _textAddress.text =model.poi[@"spot_region"];
    }else{
        _textView.hidden = YES;
    }
}
#pragma mark  ==设置详情页frame==
-(void)settingSubviewFrame{
    if (![_travelNoteFrame.traveNotesModel.photo_1600 isEqualToString:@""]) {
        _iamgeView.frame =_travelNoteFrame.iamgeViewFrame;
    }
    self.iamgeView.frame = self.travelNoteFrame.iamgeViewFrame;
    self.textTitle.frame = self.travelNoteFrame.textTitleFrame;
    self.imageClock.frame = self.travelNoteFrame.imageClockF;
    self.textView.frame = self.travelNoteFrame.textViewF;
    self.imageV.frame = self.travelNoteFrame.imageVF;
    self.textAddress.frame = self.travelNoteFrame.textAddressF;
    self.textDate.frame = self.travelNoteFrame.textDateF;
    self.addressView.frame = self.travelNoteFrame.addressViewF;
}
@end
