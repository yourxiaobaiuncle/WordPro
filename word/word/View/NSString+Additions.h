//
//  NSString+Additions.h
//  qifuyuniOS
//
//  Created by Amazing on 16/7/4.
//  Copyright © 2016年 车福网络科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (NSUInteger)hexValue;
//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
