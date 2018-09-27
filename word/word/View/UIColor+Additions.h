//
//  UIColor+Additions.h
//  qifuyuniOS
//
//  Created by Amazing on 16/7/4.
//  Copyright © 2016年 车福网络科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+ (UIColor *)colorWithHex:(NSString *)hex andColorAlpha:(CGFloat)colorAlpha;
+ (NSAttributedString*)renderAttribute:(NSArray*)text  :(NSArray*)attributes :(NSArray*)value;
@end
