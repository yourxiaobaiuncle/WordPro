//
//  ChooseEdtingViewController.h
//  word
//
//  Created by 信和财富 on 2018/1/22.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ChooseEdtingModelType) {//手势控制哪种转场
    model111=0,
    model222,
    model333,
    model444
};
@interface ChooseEdtingViewController : UIViewController
@property(nonatomic,assign)ChooseEdtingModelType modelType;
-(instancetype)initWithEdtingViewWithViewFrame:(CGRect)viewFrame andLabelFrame:(CGRect)labelFrame andTitleFrame:(CGRect)titleFrame andWordViewModelTypr:(ChooseEdtingModelType) modelType;
@end
