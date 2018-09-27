//
//  TextFieldView.m
//  word
//
//  Created by Mac on 2017/12/29.
//  Copyright © 2017年 xinHeYanJunYuan. All rights reserved.
//

#import "TextFieldView.h"

@implementation TextFieldView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self creatTextFieldView];
    }
    return self;
}
-(void)creatTextFieldView{
    for (int m=0; m<5; m++) {
        UITextField *textField=[[UITextField alloc] initWithFrame:CGRectMake(0, m*self.bounds.size.height/5, self.bounds.size.width, self.bounds.size.height/5)];
        textField.tag=100+m;
        if (m==0) {
            textField.placeholder=@"请输入编辑内容";
        }
        textField.font=[UIFont systemFontOfSize:14];
        [self addSubview:textField];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
