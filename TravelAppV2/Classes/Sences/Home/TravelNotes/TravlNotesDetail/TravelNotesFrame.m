//
//  TravelNotesFrame.m
//  TravelAppV2
//
//  Created by chenqiang on 15/10/8.
//  Copyright © 2015年 chenqiang. All rights reserved.
//

#import "TravelNotesFrame.h"
//cell的边框
#define  KcellBorder  20
//imageView的宽高
#define  KImageViewW  traveNotesModel.length-40
#define  KImageViewH  360
#define  KViewX  traveNotesModel.length-150;
#define  KViewY  230;
#define  ktextFont  [UIFont systemFontOfSize:17]
#define KPicBorder  0
@implementation TravelNotesFrame
-(void)setTraveNotesModel:(TravelNotesModel *)traveNotesModel{
    _traveNotesModel = traveNotesModel;
   //图片
        CGFloat  imageX =KcellBorder;
        CGFloat  imageY =KcellBorder-10;
        _iamgeViewFrame =CGRectMake(imageX, imageY, KImageViewW, KImageViewW);
    
   //文本
    CGFloat  textX =KcellBorder;
    CGFloat  textY =CGRectGetMaxY(_iamgeViewFrame) +KcellBorder-10;
    CGFloat  textW =KImageViewW ;
    CGSize  contentsize = [traveNotesModel.text  sizeWithFont:ktextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _textTitleFrame = CGRectMake(textX, textY, contentsize.width, contentsize.height);
    
    //时钟
    CGFloat  ImageClockX =KcellBorder;
    CGFloat  ImageClockY =CGRectGetMaxY(_textTitleFrame)+KcellBorder;
    CGFloat  ImageClockW =KcellBorder-10;
    CGFloat  ImageClockH = KcellBorder-10;
    _imageClockF=CGRectMake(ImageClockX, ImageClockY, ImageClockW, ImageClockH);
    //日期
    CGFloat textDateX =KcellBorder * 2 -10;
    CGFloat textDateY =ImageClockY;
    CGFloat textDateW =KcellBorder+140;
    CGFloat textDateH =ImageClockH;
    _textDateF =CGRectMake(textDateX, textDateY, textDateW, textDateH);
    //图标上的View
    CGFloat  addressViewX =CGRectGetMaxX(_textDateF) +30;
    CGFloat  addressViewY =ImageClockY ;
    CGFloat  addressViewW =KcellBorder+120;
    CGFloat  addressViewH =KcellBorder-10;
    _addressViewF = CGRectMake(addressViewX, addressViewY, addressViewW, addressViewH);
    
    //计算cell的高度
    if([_traveNotesModel.photo_1600 isEqualToString:@""])
    {
        _cellHegth =contentsize.height + ImageClockH +KcellBorder+40;
        _textTitleFrame = CGRectMake(textX, textY-330, contentsize.width, contentsize.height);
        _textDateF =CGRectMake(textDateX, textDateY-330, textDateW, textDateH);
        _addressViewF = CGRectMake(addressViewX, addressViewY-330, addressViewW, addressViewH);

    }else{
        _cellHegth =CGRectGetMaxY(_imageClockF)+KcellBorder;
    }
    
    //图标
    CGFloat imageVX =KPicBorder;
    CGFloat imageVY =KPicBorder;
    CGFloat imageVW =KcellBorder-10;
    CGFloat imageVH =KcellBorder-10;
    _imageVF = CGRectMake(imageVX, imageVY, imageVW, imageVH);
    //地址
    CGFloat  addressVX =CGRectGetMaxX(_imageVF) +KcellBorder-15;
    CGFloat  addressVY = imageVY;
    CGFloat  addressVW =KcellBorder+80;
    CGFloat  addressVH =KcellBorder-10;
    _textAddressF =CGRectMake(addressVX, addressVY, addressVW, addressVH);

}
@end
