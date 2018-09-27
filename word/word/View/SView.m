//
//  SView.m
//  word
//
//  Created by 信和财富 on 2018/1/29.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import "SView.h"

@implementation SView
-(instancetype)initWithFrame:(CGRect)frame andString:(NSString *)string andTextFont:(CGFloat)font andTextColor:(UIColor *)textColor andWordStyle:(wordStyle)wordStyle andFontFimaly:(NSString *)fontFimaly{
    if (self=[super initWithFrame:frame]) {
        self.string=string;
        self.wordFont=font;
        self.wordColor=textColor;
        self.wordSty=wordStyle;
        self.fontFimaly=fontFimaly;   
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef ref=UIGraphicsGetCurrentContext();//获取当前上下文
    CGContextSetTextMatrix(ref, CGAffineTransformIdentity);
    CGContextTranslateCTM(ref, -5*XHSizeW, self.bounds.size.height);
    CGContextScaleCTM(ref, 1.0, -1.0);
    
    NSDictionary*dict=@{(NSString *)kCTVerticalFormsAttributeName:self.wordSty==vertical?[NSNumber numberWithBool:YES]:[NSNumber numberWithBool:false]};
    NSAttributedString *str = [[NSAttributedString alloc ]
                               initWithString:self.string
                               attributes:dict];
    NSMutableAttributedString*mutableAttributedString=[[NSMutableAttributedString alloc] initWithAttributedString:str];
    //[mutableAttributedString ]
    [mutableAttributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:self.fontFimaly size:17] range:NSMakeRange(0, mutableAttributedString.length)];
    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:self.wordColor range:NSMakeRange(0, mutableAttributedString.length)];
    CFMutableAttributedStringRef attString=(__bridge CFMutableAttributedStringRef)mutableAttributedString;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) attString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = self.bounds;
    CGPathAddRect(path, NULL, bounds);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, (CFDictionaryRef)[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInt:self.wordSty==vertical?1:0], (NSString *)kCTFrameProgressionAttributeName, nil]);
    NSArray* arrayRef=(NSArray*)CTFrameGetLines(frame);
    CGPoint *lineOrigins = malloc(arrayRef.count * sizeof(CGPoint));
    CTFrameGetLineOrigins((CTFrameRef)frame, CFRangeMake(0, arrayRef.count), lineOrigins);
    
   //获取特效字
    NSInteger index= arc4random()%self.string.length;
    
    int i=0;
    for (id line in arrayRef) {
        NSArray *glyphRuns = (NSArray *)CTLineGetGlyphRuns((CTLineRef)line);
        CGFloat width =lineOrigins[i].x-lineOrigins[0].x;
        CGFloat height =lineOrigins[i].y;
        for (id run in glyphRuns)
        {
            
//            CGFloat width1=[(NSString *)[self.string substringFromIndex:index] boundingRectWithSize: options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width;
        
            CTRunRef runO = (__bridge CTRunRef)run;
            CFDictionaryRef dicRef=CTRunGetAttributes((CTRunRef)run);
            NSDictionary *dic=(__bridge NSDictionary *)dicRef;
//            if ([dic objectForKey:@"NSBackgroundColor"]!=nil)
//            {
                UIColor *BGColor=mainColor;
                CGPoint *ary=(CGPoint *)CTRunGetPositionsPtr((CTRunRef)run);
                float lineheight;
                if (arrayRef.count>=2)
                {
                    lineheight=lineOrigins[arrayRef.count-2].y-lineOrigins[arrayRef.count-1].y;
                }
                else
                {
                    lineheight=28;
                }
            //CGRect runBounds;
            CGFloat ascent;
            CGFloat descent;
                float RunWidth=CTRunGetTypographicBounds((CTRunRef)run, CFRangeMake(1, 1),&ascent,&descent , NULL);
                float runHeight=ascent+descent;
            CFRange d=CTRunGetStringRange(runO);
            //CTRunGetAttributes(runO);
            CGFloat xOffset = CTLineGetOffsetForStringIndex((CTLineRef)line, CTRunGetStringRange(runO).location, NULL);
            CGFloat x = lineOrigins[i].x + xOffset;
              CGRect rect = [str boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            
            CGFloat y = height-(arc4random()%d.length)*rect.size.height-50*XHSizeH;
            NSLog(@"%f",y);
            
            
                CGRect rectangle = CGRectMake(x-5*XHSizeW, y,rect.size.width-10*XHSizeW, runHeight);
                CGContextSetFillColorWithColor(ref,BGColor.CGColor);
                CGContextFillRect(ref , rectangle);
            
                
                //                    绘制矩形框
                                    CGContextSetStrokeColorWithColor(ref, [BGColor CGColor]);//边框色
            //cgcontextsetc
                                    CGContextAddRect(ref, rectangle);
                                    CGContextStrokePath(ref);//绘制
                
           //r }
        }
        i++;
    }
    
    
    
    CTFrameDraw(frame, ref);
    CFRelease(framesetter);
    CFRelease(frame);
    CFRelease(path);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
