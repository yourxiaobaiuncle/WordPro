//
//  SView.h
//  word
//
//  Created by 信和财富 on 2018/1/29.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

typedef enum : NSUInteger {
    vertical=0,
    horizontal
} wordStyle;
@interface SView : UIView
-(instancetype)initWithFrame:(CGRect)frame andString:(NSString*)string andTextFont:(CGFloat)font andTextColor:(UIColor*)textColor andWordStyle:(wordStyle)wordStyle andFontFimaly:(NSString*)fontFimaly;
//-(void)drawRect:(CGRect)rect andString:(NSString*)string;
@property(nonatomic,copy)NSString*string;
@property(nonatomic,assign)CGFloat wordFont;
@property(nonatomic,copy)UIColor*wordColor;
@property(nonatomic,assign)wordStyle wordSty;
@property(nonatomic,copy)NSString*fontFimaly;

@end
