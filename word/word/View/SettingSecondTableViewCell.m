//
//  SettingSecondTableViewCell.m
//  word
//
//  Created by 信和财富 on 2018/1/15.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import "SettingSecondTableViewCell.h"

@implementation SettingSecondTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.tintColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.leftLable];
    [self addSubview:self.MyimageView];
}
-(UILabel *)leftLable{
    if (!_leftLable) {
        _leftLable=[[UILabel alloc] initWithFrame:CGRectMake(30*XHSizeW, 0, 200*XHSizeW, self.bounds.size.height)];
        _leftLable.textColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
        CGPoint center=_leftLable.center;
        center.y=22.5*XHSizeH;
        _leftLable.center=center;
        [_leftLable setFont:[UIFont fontWithName:@"HYa5gf" size:17*XHSizeW]];
    }
    return _leftLable;
}
-(UIImageView *)MyimageView{
    if (!_MyimageView) {
        _MyimageView=[[UIImageView alloc] initWithFrame:CGRectMake(5*XHSizeW, 0, 17*XHSizeW, 14*XHSizeW)];
    }
    return _MyimageView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
