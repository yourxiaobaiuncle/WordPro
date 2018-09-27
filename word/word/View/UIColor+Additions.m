//
//  UIColor+Additions.m
//  qifuyuniOS
//
//  Created by Amazing on 16/7/4.
//  Copyright © 2016年 车福网络科技. All rights reserved.
//

#import "UIColor+Additions.h"
#import "NSString+Additions.h"

@implementation UIColor (Additions)

+ (UIColor *)colorWithHex:(NSString *)hex andColorAlpha:(CGFloat)colorAlpha{
    // Remove `#`
    if (!hex || hex.length<3) {
        return [UIColor blackColor];
    }
    if ([[hex substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"#"]) {
        hex = [hex substringFromIndex:1];
    }
    
    // Invalid if not 3, 6, or 8 characters
    NSUInteger length = [hex length];
    if (length != 3 && length != 6 && length != 8) {
        return nil;
    }
    
    // Make the string 8 characters long for easier parsing
    if (length == 3) {
        NSString *r = [hex substringWithRange:NSMakeRange(0, 1)];
        NSString *g = [hex substringWithRange:NSMakeRange(1, 1)];
        NSString *b = [hex substringWithRange:NSMakeRange(2, 1)];
        hex = [NSString stringWithFormat:@"%@%@%@%@%@%@ff",r, r, g, g, b, b];
    } else if (length == 6) {
        hex = [hex stringByAppendingString:@"ff"];
    }
    
    //extend [NSString hexValue]
    CGFloat red = [[hex substringWithRange:NSMakeRange(0, 2)] hexValue] / 255.0f;
    CGFloat green = [[hex substringWithRange:NSMakeRange(2, 2)] hexValue] / 255.0f;
    CGFloat blue = [[hex substringWithRange:NSMakeRange(4, 2)] hexValue] / 255.0f;
    CGFloat alpha = [[hex substringWithRange:NSMakeRange(6, 2)] hexValue] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:colorAlpha];
}

+ (NSAttributedString*)renderAttribute:(NSArray*)text  :(NSArray*)attributes :(NSArray*)value
{
    int location = 0;
    
    NSMutableString *renderString = [[NSMutableString alloc] initWithString:@""];
    for(int i = 0; i<text.count;i++)
    {
        renderString = [NSMutableString stringWithString:[renderString stringByAppendingString:text[i]]];
    }
    
    NSMutableAttributedString *renderAttributeString = [[NSMutableAttributedString alloc] initWithString:renderString];
    for(int i = 0; i<text.count;i++)
    {
        NSRange range = {location,[text[i] length]};
        location += [text[i] length];
        
        [renderAttributeString addAttribute:attributes[i] value:value[i] range:range];
    }
    
    return renderAttributeString;
}

@end
