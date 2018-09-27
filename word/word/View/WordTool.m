
//
//  WordTool.m
//  word
//
//  Created by 信和财富 on 2018/1/24.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import "WordTool.h"

@implementation WordTool
+(CAShapeLayer *)creatPointLine:(UIView*)view{
    CAShapeLayer *border = [CAShapeLayer layer];
    
    //虚线的颜色
    border.strokeColor = mainColor.CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    //设置路径
    border.path = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    
    border.frame = view.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    
    return border;
}
+(UIImage *)clicpPictureViewWithRect:(CGRect)aRect andClicpView:(UIView*)view //arect 想要截图的区域
    
    {
        
        CGFloat scale = [UIScreen mainScreen].scale;
        
        aRect.origin.x *= scale;
        
        aRect.origin.y *= scale;
        
        aRect.size.width *= scale;
        
        aRect.size.height *= scale;
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.frame.size.width, view.frame.size.height), YES, scale);
        
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        CGImageRef imageRef = viewImage.CGImage;
        
        CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, aRect);
        
        UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
        
        return sendImage;
        
    }
+(void)clicpRice:(UIView *)view andRadius:(CGFloat)Radius{
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=Radius;
}
+(BOOL)isSavePic{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"savePic"] isEqualToString:@"0"]) {
        return NO;
    }else{
        return YES;
    }
}
+(BOOL)isSavePicToPhotoAlbum{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"savePicToPhotoAlbum"] isEqualToString:@"0"]) {
        return NO;
    }else{
        return YES;
    }
}

@end
