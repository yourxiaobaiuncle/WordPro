//
//  EdtingModelView.h
//  word
//
//  Created by Mac on 2018/1/3.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EdtingModelViewDelegete<NSObject>
-(void)tapGesClickDelegete:(UITapGestureRecognizer*)sender andTextViewString:(NSString*)textViewString andWordNum:(NSInteger)wordNum andFontFimaly:(NSString*)fontFimaly;
@end
typedef NS_ENUM(NSUInteger, WordViewModelType) {//手势控制哪种转场
    model11=0,
    model22,
    model33,
    model44
};
typedef NS_ENUM(NSUInteger, tapClickType) {//手势控制哪种转场
    model1Title=10,
    model1Text,
    model1Author,
    
    model2Title,
    model2Text,
    model2Author,
    
    model3Title,
    model3Text,
    model3Author,
    
    model4Title,
    model4Text,
    model4Author
};

@interface EdtingModelView : UIView
-(instancetype)initEdtingViewWithViewFrame:(CGRect)edtingViewFrame andLabelFrame:(CGRect)labelFrame andTitleFrame:(CGRect)titleFrame andWordViewModelTypr:(WordViewModelType)modelType;
@property(nonatomic,weak)id<EdtingModelViewDelegete>delegete;
@property(nonatomic,copy)NSString*fontFimaly;
@end
