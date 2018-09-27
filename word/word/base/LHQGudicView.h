//
//  LHQGudicView.h
//  手机贷
//
//  Created by hongqiangli on 17/3/20.
//  Copyright © 2017年 李洪强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHQGudicView : UIView
/**
 *  选中page的指示器颜色，默认白色
 */
@property (nonatomic, strong) UIColor *currentColor;
/**
 *  其他状态下的指示器的颜色，默认
 */
@property (nonatomic, strong) UIColor *nomalColor;
/**
 *  不带按钮的引导页，滑动到最后一页，再向右滑直接隐藏引导页
 *
 *  @param imageNames 背景图片数组
 *
 *  @return   LaunchIntroductionView对象
 */
+(instancetype)sharedWithImages:(NSArray *) imageNames;
/**
 *  带按钮的引导页
 *
 *  @param imageNames      背景图片数组
 *  @param buttonImageName 按钮的图片
 *  @param frame           按钮的frame
 *
 *  @return LaunchIntroductionView对象
 */
+(instancetype)sharedWithImages:(NSArray *) imageNames buttonImage:(NSString *) buttonImageName buttonFrame:(CGRect ) frame;

@end
