//
//  EdtingModelView.m
//  word
//
//  Created by Mac on 2018/1/3.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import "EdtingModelView.h"
#import "SView.h"
@implementation EdtingModelView
-(instancetype)initEdtingViewWithViewFrame:(CGRect)edtingViewFrame andLabelFrame:(CGRect)labelFrame andTitleFrame:(CGRect)titleFrame andWordViewModelTypr:(WordViewModelType)modelType{
    if (self=[super initWithFrame:edtingViewFrame]) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.shadowPath=[[UIBezierPath
                                bezierPathWithRect:self.bounds] CGPath];
        self.layer.shadowOffset=CGSizeMake(0.1,0.1);
        self.layer.shadowColor=[UIColor blackColor].CGColor;
        self.layer.shadowOpacity =0.1;
        self.layer.shadowRadius = 4;
        self.fontFimaly=@"FZSSJW--GB1-0";
        if (modelType==model11) {
            [self creatModel1ViewwithLabelText:@" 点击输入内容"];
            [self creatModel1ViewwithLabelAuthorText:@" 作者"];
        }else if (modelType==model22){
            [self creatModel2ViewwithLabel:@" 点击输入内容"];
            [self creatModel2ViewwithTitleLabel:@" 标题"];
            [self creatModel2ViewwithAoutherLabel:@" 作者"];
        }else if (modelType==model33){
            [self creatModel3ViewwithLabelText:@"点击输入内容"];
            [self creatModel3ViewwithLabelAuthorText:@"作者"];
        }else if (modelType==model44){
            [self creatModel4ViewwithLabelText:@"点击输入内容"];
            [self creatModel4ViewwithLabelAuthorText:@"作者"];
        }
    }
    return self;
}
-(void)tapGesTextClick:(UITapGestureRecognizer*)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getString:) name:@"getStringFromEdtingView" object:nil];
    
    if (sender.view.tag==model1Text||sender.view.tag==model1Author||sender.view.tag==model2Title||sender.view.tag==model2Text||sender.view.tag==model2Author) {
        SView*sview=(SView*)[sender.view viewWithTag:sender.view.tag];
       [self.delegete tapGesClickDelegete:sender andTextViewString:sview.string andWordNum:200 andFontFimaly:self.fontFimaly];
    }else{
        UILabel*label=(UILabel*)[sender.view viewWithTag:sender.view.tag];
        [self.delegete tapGesClickDelegete:sender andTextViewString:label.text andWordNum:200 andFontFimaly:self.fontFimaly];
    }
}
-(void)getString:(NSNotification*)sender{
    NSDictionary*dict=sender.object;
    self.fontFimaly=[[dict allValues] lastObject];
    
    NSString*tagStr=[dict objectForKey:@"tag"];
    NSString*textStr=[dict objectForKey:@"text"];
    NSString*fontStr=[dict objectForKey:@"fontFimaly"];
    if ([tagStr integerValue]==model2Title) {
        [self creatModel2ViewwithTitleLabel:textStr];
    }else if ([tagStr integerValue]==model2Author){
        [self creatModel2ViewwithAoutherLabel:textStr];
    }else if([tagStr integerValue]==model1Author){
        [self creatModel1ViewwithLabelAuthorText:textStr];
    }else if([tagStr integerValue]==model1Text){
        [self creatModel1ViewwithLabelText:textStr];
        
    }else if([tagStr integerValue]==model2Text){
        [self creatModel2ViewwithLabel:textStr];
    }else if ([tagStr integerValue]==model3Text){
        [self creatModel3ViewwithLabelText:textStr];
    }else if ([tagStr integerValue]==model3Author){
        [self creatModel3ViewwithLabelAuthorText:textStr];
    }else if ([tagStr integerValue]==model4Text){
        [self creatModel4ViewwithLabelText:textStr];
    }else if ([tagStr integerValue]==model4Author){
        [self creatModel4ViewwithLabelAuthorText:textStr];
    }
    self.fontFimaly=fontStr;
}
#pragma mark- model1
-(void)creatModel1ViewwithLabelText:(NSString*)stringText{
    if ([self viewWithTag:model1Text]) {
        [[self viewWithTag:model1Text] removeFromSuperview];
    }
    SView*sv;
    if ([stringText isEqualToString:@" 点击输入内容"]||stringText.length==0) {
        sv=[[SView alloc] initWithFrame:CGRectMake(287*XHSizeW-21*XHSizeW*8, 57*XHSizeH, 21*8*XHSizeW, 238*XHSizeH) andString:@" 点击输入内容" andTextFont:18.0f andTextColor:[UIColor lightGrayColor] andWordStyle:vertical andFontFimaly:self.fontFimaly];
        [sv.layer addSublayer:[WordTool creatPointLine:sv]];
    }else{
        sv=[[SView alloc] initWithFrame:CGRectMake(287*XHSizeW-21*XHSizeW*8, 57*XHSizeH, 21*8*XHSizeW, 238*XHSizeH) andString:stringText andTextFont:18.0f andTextColor:[UIColor colorWithHex:@"#3C3C3C" andColorAlpha:1.0] andWordStyle:vertical andFontFimaly:self.fontFimaly];
    }
    sv.backgroundColor=[UIColor clearColor];
    [self addSubview:sv];
    sv.tag=model1Text;
    UITapGestureRecognizer *tapText=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesTextClick:)];
    [sv addGestureRecognizer:tapText];
}
-(void)creatModel1ViewwithLabelAuthorText:(NSString*)authorString{
    
    if ([self viewWithTag:model1Author]) {
        [[self viewWithTag:model1Author] removeFromSuperview];
    }
    SView*sv;
    if ([authorString isEqualToString:@" 作者"]||authorString.length==0) {
        sv=[[SView alloc] initWithFrame:CGRectMake(20*XHSizeW, 150*XHSizeH, 28*XHSizeW, 142*XHSizeH) andString:@" 作者" andTextFont:10.0f andTextColor:[UIColor lightGrayColor] andWordStyle:vertical andFontFimaly:self.fontFimaly];
        [sv.layer addSublayer:[WordTool creatPointLine:sv]];
    }else{
        sv=[[SView alloc] initWithFrame:CGRectMake(20*XHSizeW, 150*XHSizeH, 28*XHSizeW, 142*XHSizeH) andString:authorString andTextFont:12.0f andTextColor:[UIColor colorWithHex:@"#3C3C3C" andColorAlpha:1.0] andWordStyle:vertical andFontFimaly:self.fontFimaly];
    }
    [self addSubview:sv];
    sv.backgroundColor=[UIColor clearColor];
    UITapGestureRecognizer *tapauthor=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesTextClick:)];
    [sv addGestureRecognizer:tapauthor];
    sv.tag=model1Author;
}
#pragma -mark 模板2
-(void)creatModel2ViewwithAoutherLabel:(NSString*)aoutherString{
    
    if ([self viewWithTag:model2Author]) {
        [[self viewWithTag:model2Author] removeFromSuperview];
    }
    SView*sv;
    if ([aoutherString isEqualToString:@" 作者"]||aoutherString.length==0) {
        sv=[[SView alloc] initWithFrame:CGRectMake(20*XHSizeW, 150*XHSizeH, 28*XHSizeW, 142*XHSizeH) andString:@" 作者" andTextFont:11.0f andTextColor:[UIColor lightGrayColor] andWordStyle:vertical andFontFimaly:self.fontFimaly];
        [sv.layer addSublayer:[WordTool creatPointLine:sv]];
    }else{
        sv=[[SView alloc] initWithFrame:CGRectMake(20*XHSizeW, 150*XHSizeH, 28*XHSizeW, 142*XHSizeH) andString:aoutherString andTextFont:11.0f andTextColor:[UIColor colorWithHex:@"#3C3C3C" andColorAlpha:1.0] andWordStyle:vertical andFontFimaly:self.fontFimaly];
    }
    [self addSubview:sv];
    sv.backgroundColor=[UIColor clearColor];
    UITapGestureRecognizer *tapauthor=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesTextClick:)];
    [sv addGestureRecognizer:tapauthor];
    sv.tag=model2Author;
}
-(void)creatModel2ViewwithTitleLabel:(NSString*)titleString{
    
    if ([self viewWithTag:model2Title]) {
        [[self viewWithTag:model2Title] removeFromSuperview];
    }
    SView*sv;
    if ([titleString isEqualToString:@" 标题"]||titleString.length==0) {
        sv=[[SView alloc] initWithFrame:CGRectMake(290*XHSizeW, 54*XHSizeH, 34*XHSizeW, 212*XHSizeH) andString:@" 标题" andTextFont:16.0f andTextColor:[UIColor lightGrayColor] andWordStyle:vertical andFontFimaly:self.fontFimaly];
        [sv.layer addSublayer:[WordTool creatPointLine:sv]];
    }else{
        sv=[[SView alloc] initWithFrame:CGRectMake(290*XHSizeW, 54*XHSizeH, 34*XHSizeW, 212*XHSizeH) andString:titleString andTextFont:16.0f andTextColor:[UIColor colorWithHex:@"#3C3C3C" andColorAlpha:1.0] andWordStyle:vertical andFontFimaly:self.fontFimaly];
    }
    [self addSubview:sv];
    sv.backgroundColor=[UIColor clearColor];
    UITapGestureRecognizer *tapauthor=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesTextClick:)];
    [sv addGestureRecognizer:tapauthor];
    sv.tag=model2Title;
}
-(void)creatModel2ViewwithLabel:(NSString*)string{
    
    if ([self viewWithTag:model2Text]) {
        [[self viewWithTag:model2Text] removeFromSuperview];
    }
    SView*sv;
    if ([string isEqualToString:@" 点击输入内容"]||string.length==0) {
        sv=[[SView alloc] initWithFrame:CGRectMake(287*XHSizeW-21*XHSizeW*8-30*XHSizeW, 57*XHSizeH, 21*8*XHSizeW, 238*XHSizeH) andString:@" 点击输入内容" andTextFont:18.0f andTextColor:[UIColor lightGrayColor] andWordStyle:vertical andFontFimaly:self.fontFimaly];
        [sv.layer addSublayer:[WordTool creatPointLine:sv]];
    }else{
        sv=[[SView alloc] initWithFrame:CGRectMake(287*XHSizeW-21*XHSizeW*8-30*XHSizeW, 57*XHSizeH, 21*8*XHSizeW, 238*XHSizeH) andString:string andTextFont:18.0f andTextColor:[UIColor colorWithHex:@"#3C3C3C" andColorAlpha:1.0] andWordStyle:vertical andFontFimaly:self.fontFimaly];
    }
    sv.backgroundColor=[UIColor clearColor];
    [self addSubview:sv];
    sv.tag=model2Text;
    UITapGestureRecognizer *tapText=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesTextClick:)];
    [sv addGestureRecognizer:tapText];

}
#pragma -mark model3
-(void)creatModel3ViewwithLabelText:(NSString*)string{
    
    if ([self viewWithTag:model3Text]) {
        [[self viewWithTag:model3Text] removeFromSuperview];
    }
    UILabel*textLabel=[[UILabel alloc] initWithFrame:CGRectMake(43*XHSizeW,62*XHSizeH ,269*XHSizeW ,136*XHSizeH)];
    [self addSubview:textLabel];
    if ([string isEqualToString:@"点击输入内容"]||string.length==0) {
        [textLabel.layer addSublayer:[WordTool creatPointLine:textLabel]];
        textLabel.textColor=[UIColor lightGrayColor];
        textLabel.textAlignment=NSTextAlignmentLeft;
        textLabel.text=@"点击输入内容";
    }else{
        textLabel.textColor=[UIColor colorWithHex:@"#3C3C3C" andColorAlpha:1.0];
        textLabel.textAlignment=NSTextAlignmentCenter;
        textLabel.text=string;
    }
    textLabel.layer.masksToBounds=YES;
    textLabel.layer.cornerRadius=5;
    textLabel.tag=model3Text;
    textLabel.numberOfLines=0;
    textLabel.font=[UIFont systemFontOfSize:16*XHSizeW];
    textLabel.userInteractionEnabled=YES;
    UITapGestureRecognizer*tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesTextClick:)];
    [textLabel addGestureRecognizer:tapGes];
}
-(void)creatModel3ViewwithLabelAuthorText:(NSString*)string{
    if ([self viewWithTag:model3Author]) {
        [[self viewWithTag:model3Author] removeFromSuperview];
    }
    UILabel*titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(104*XHSizeW,308*XHSizeH,148*XHSizeW,20*XHSizeH)];
    [self addSubview:titleLabel];
    if ([string isEqualToString:@"作者"]||string.length==0) {
        [titleLabel.layer addSublayer:[WordTool creatPointLine:titleLabel]];
        titleLabel.textColor=[UIColor lightGrayColor];
        titleLabel.text=@"作者";
    }else{
        titleLabel.textColor=[UIColor colorWithHex:@"#4D4D4D" andColorAlpha:1.0];
        titleLabel.text=string;
    }
    titleLabel.tag=model3Author;
    titleLabel.font=[UIFont systemFontOfSize:10*XHSizeW];
    titleLabel.userInteractionEnabled=YES;
    titleLabel.textAlignment=NSTextAlignmentCenter;
    UITapGestureRecognizer*tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesTextClick:)];
    [titleLabel addGestureRecognizer:tapGes];
}
-(void)creatModel4ViewwithLabelText:(NSString*)string{
    if ([self viewWithTag:model4Text]) {
        [[self viewWithTag:model4Text] removeFromSuperview];
    }
    UILabel*textLabel=[[UILabel alloc] initWithFrame:CGRectMake(18*XHSizeW,30*XHSizeH ,209*XHSizeW ,200*XHSizeH)];
    [self addSubview:textLabel];
    if ([string isEqualToString:@"点击输入内容"]||string.length==0) {
        [textLabel.layer addSublayer:[WordTool creatPointLine:textLabel]];
        textLabel.textColor=[UIColor lightGrayColor];
        textLabel.text=@"点击输入内容";
    }else{
        textLabel.textColor=[UIColor colorWithHex:@"#3C3C3C" andColorAlpha:1.0];
        textLabel.text=string;
    }
    
    textLabel.numberOfLines=0;
    textLabel.font=[UIFont systemFontOfSize:14*XHSizeW];
    textLabel.tag=model4Text;
    textLabel.userInteractionEnabled=YES;
    UITapGestureRecognizer*tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesTextClick:)];
    [textLabel addGestureRecognizer:tapGes];
    [self creatTimeView];
}
-(void)creatModel4ViewwithLabelAuthorText:(NSString*)string{
    
    if ([self viewWithTag:model4Author]) {
        [[self viewWithTag:model4Author] removeFromSuperview];
    }
    UILabel*authorLabel=[[UILabel alloc] initWithFrame:CGRectMake(123*XHSizeW,251*XHSizeH,105*XHSizeW,20*XHSizeH)];
    [self addSubview:authorLabel];
    if ([string isEqualToString:@"作者"]) {
        [authorLabel.layer addSublayer:[WordTool creatPointLine:authorLabel]];
        authorLabel.textColor=[UIColor lightGrayColor];
        authorLabel.text=@"作者";
    }else{
        authorLabel.textColor=[UIColor colorWithHex:@"#4D4D4D" andColorAlpha:1.0];
        authorLabel.text=string;
    }
    
    authorLabel.userInteractionEnabled=YES;
    authorLabel.tag=model4Author;
    UITapGestureRecognizer*tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesTextClick:)];
    [authorLabel addGestureRecognizer:tapGes];
    authorLabel.textAlignment=NSTextAlignmentCenter;
    authorLabel.font=[UIFont systemFontOfSize:10*XHSizeW];
}
#pragma -mark 生成时间view
-(void)creatTimeView{
    UILabel*timeDayLabel=[[UILabel alloc] initWithFrame:CGRectMake(289*XHSizeW, 32*XHSizeH, 55*XHSizeW, 42*XHSizeH)];
    UILabel*timeYearAndDayLabel=[[UILabel alloc] initWithFrame:CGRectMake(283*XHSizeW, 78*XHSizeH, 66*XHSizeW, 17*XHSizeH)];
    
    [self addSubview:timeYearAndDayLabel];
    [self addSubview:timeDayLabel];
    NSArray *arrayStr=[[self getTimeDate] componentsSeparatedByString:@"--"];
    if (arrayStr.count==2) {
        timeYearAndDayLabel.text=arrayStr[0];
        timeDayLabel.text=arrayStr[1];
    }
    timeYearAndDayLabel.textColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
    timeDayLabel.textColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
    timeYearAndDayLabel.font=[UIFont systemFontOfSize:12*XHSizeW];
    timeDayLabel.font=[UIFont systemFontOfSize:30*XHSizeW];
    timeDayLabel.textAlignment=NSTextAlignmentCenter;
    timeYearAndDayLabel.textAlignment=NSTextAlignmentCenter;
    UIView*viewLine1=[[UIView alloc] initWithFrame:CGRectMake(289*XHSizeW, 32*XHSizeH,55*XHSizeW , 2*XHSizeH)];
    viewLine1.backgroundColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
    [self addSubview:viewLine1];
    UIView*viewLine2=[[UIView alloc] initWithFrame:CGRectMake(289*XHSizeW, 75*XHSizeH,55*XHSizeW , 2*XHSizeH)];
    viewLine2.backgroundColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
    [self addSubview:viewLine2];
}
#pragma -mark 获取时间
-(NSString*)getTimeDate{
    NSDate  *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    
    NSInteger year=[components year];
    NSInteger month=[components month];
    NSInteger day=[components day];
    if (day<10) {
        if (month<10) {
           return [NSString stringWithFormat:@"%ld-0%ld--0%ld",year,month,day];
        }else{
            return [NSString stringWithFormat:@"%ld-%ld--0%ld",year,month,day];
        }
    }else{
        if (month<10) {
            return [NSString stringWithFormat:@"%ld-0%ld--%ld",year,month,day];
        }else{
            return [NSString stringWithFormat:@"%ld-%ld--%ld",year,month,day];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
