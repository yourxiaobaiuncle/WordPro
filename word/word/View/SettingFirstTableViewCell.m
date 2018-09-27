//
//  SettingFirstTableViewCell.m
//  word
//
//  Created by 信和财富 on 2018/1/15.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import "SettingFirstTableViewCell.h"

@implementation SettingFirstTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.tintColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.leftLable];
    [self addSubview:self.MySwich];
}
-(UILabel *)leftLable{
    if (!_leftLable) {
        _leftLable=[[UILabel alloc] initWithFrame:CGRectMake(8*XHSizeW, 0, 200*XHSizeW, self.bounds.size.height)];
        _leftLable.textColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
        CGPoint center=_leftLable.center;
        center.y=22.5*XHSizeH;
        _leftLable.center=center;
        //_leftLable.font=[UIFont systemFontOfSize:17*XHSizeW];
        [_leftLable setFont:[UIFont fontWithName:@"HYa5gf" size:17*XHSizeW]];
    }
    return _leftLable;
}
-(UISwitch *)MySwich{
    if (!_MySwich) {
        _MySwich=[[UISwitch alloc] initWithFrame:CGRectMake(XHScreenW-60*XHSizeW, 0, 60*XHSizeW, 45*XHSizeH)];
        CGPoint center=_MySwich.center;
        center.y=22.5*XHSizeH;
        _MySwich.on=YES;
        _MySwich.center=center;
        _MySwich.tintColor=[UIColor colorWithHex:@"EEC894" andColorAlpha:1.0];
        _MySwich.onTintColor=[UIColor colorWithHex:@"EEC894" andColorAlpha:1.0];
        [_MySwich addTarget:self action:@selector(mySwichValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _MySwich;
}
-(void)mySwichValueChanged:(UISwitch*)sender{
    if (sender.tag==100) {
        if (sender.isOn==YES) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"savePic"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"savePic"];
        }
    }else if (sender.tag==101){
        if (sender.isOn==YES) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"savePicToPhotoAlbum"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"savePicPhotoAlbum"];
        }
    }
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
