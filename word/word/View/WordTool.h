//
//  WordTool.h
//  word
//
//  Created by 信和财富 on 2018/1/24.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UShareUI/UShareUI.h>
@interface WordTool : NSObject
+(CAShapeLayer*)creatPointLine:(UIView*)view;
+(UIImage *)clicpPictureViewWithRect:(CGRect)aRect andClicpView:(UIView*)view;
+(void)clicpRice:(UIView*)view andRadius:(CGFloat)Radius;
+(BOOL)isSavePic;
+(BOOL)isSavePicToPhotoAlbum;
@end
