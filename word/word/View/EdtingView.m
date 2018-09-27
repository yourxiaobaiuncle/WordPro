//
//  EdtingView.m
//  word
//
//  Created by Mac on 2017/12/27.
//  Copyright © 2017年 xinHeYanJunYuan. All rights reserved.
//

#import "EdtingView.h"

@implementation EdtingView

-(instancetype)initWithType:(WordModelViewType)viewType andFrame:(CGRect)frame{
    self=[super init];
    if (self) {
        self.userInteractionEnabled=YES;
        self.backgroundColor=[UIColor whiteColor];
        self.frame=frame;
        [self creatViewWithModel3];
    }
    return self;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
-(void)creatViewWithModel3{
    [self addSubview:self.textFieldView];
    
    UITextField*titleField=[[UITextField alloc] initWithFrame:CGRectMake(106*XHSizeW, 311*XHSizeH, 144*XHSizeW, 12*XHSizeH)];
    titleField.font=[UIFont systemFontOfSize:14];
    titleField.placeholder=@"请输入标题";
    titleField.tag=1000;
    [self addSubview:titleField];
}
-(TextFieldView *)textFieldView{
    if (!_textFieldView) {
        _textFieldView=[[TextFieldView alloc] initWithFrame:CGRectMake(43*XHSizeW,70*XHSizeH , 269*XHSizeW, 125*XHSizeH)];
    }
    return _textFieldView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
