//
//  NSString+Additions.m
//  qifuyuniOS
//
//  Created by Amazing on 16/7/4.
//  Copyright © 2016年 车福网络科技. All rights reserved.
//

#import "NSString+Additions.h"


@implementation NSString (Additions)

//HEX
- (NSUInteger)hexValue {
    NSUInteger result = 0;
    sscanf([self UTF8String], "%lx", &result);
    return result;
}

//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
