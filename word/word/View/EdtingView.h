//
//  EdtingView.h
//  word
//
//  Created by Mac on 2017/12/27.
//  Copyright © 2017年 xinHeYanJunYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldView.h"
typedef NS_ENUM(NSUInteger, WordModelViewType) {//手势控制哪种转场
    mdoel1=0,
    model2,
    mdoel3,
    mdoel4
};

@interface EdtingView : UIView<UITextViewDelegate>

-(instancetype)initWithType:(WordModelViewType)viewType andFrame:(CGRect)frame;
@property(nonatomic,strong)TextFieldView*textFieldView;
@end
