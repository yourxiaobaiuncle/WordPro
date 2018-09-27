//
//  InPutViewController.m
//  word
//
//  Created by Mac on 2018/1/5.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//
#import "InPutViewController.h"
@interface InPutViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate>
@property(nonatomic,strong)UITextView*myTextView;
@property(nonatomic,strong)UIButton*rightButton;
@property(nonatomic,assign)BOOL buttonDre;
@property(nonatomic,strong)UIPickerView*myPickView;
@property(nonatomic,retain)NSArray*wordStyleArray;
@property(nonatomic,retain)UIView*textViewBottomView;
@property(nonatomic,strong)UILabel*wordNumLabel;
@end
@implementation InPutViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.myTextView becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:self.rightButton];
    UIBarButtonItem*leftButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"x"] style:0 target:self action:@selector(leftBackButtonClick:)];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
    [self.view addSubview:self.myTextView];
    self.buttonDre=YES;
    /* @"FZFangSong-Z02S   FZFSJW--GB1-0"      方正仿宋简体
        @"FZKai-Z03S   FZKTJW--GB1-0"           方正楷体简体
        @"FZShuSong-Z01S    FZSSJW--GB1-0"      方正书宋简体
        @"HYJinKaiJ    HYJinKaiJ"               汉仪劲楷简
        @"HYChangSongF   HYa5gf"                汉仪长宋繁
        @"PingFangSC-Regular"                平方
     */
    self.wordStyleArray=@[@"方正仿宋简体",@"方正楷体简体",@"方正书宋简体",@"汉仪劲楷简",@"汉仪长宋繁",@"苹方"];
    [self.view addSubview:self.textViewBottomView];
    [self.view addSubview:self.myPickView];
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickViewTapGes:)];
    [self.view addGestureRecognizer:tap];
    NSArray *familyFonts = [UIFont familyNames];
//    for (NSString * fontStr in familyFonts) {
//        NSArray *fonts = [UIFont fontNamesForFamilyName:fontStr];
//        for (NSString *fontStr in fonts) {
//            NSLog(@"fontStr =  %@" , fontStr);
//        }
//    }
    // Do any additional setup after loading the view.
}
-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame=CGRectMake(XHScreenW-60, 10, 50, 30);
        _rightButton.backgroundColor=[UIColor whiteColor];
        _rightButton.backgroundColor=[UIColor clearColor];
        _rightButton.layer.borderColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1].CGColor;
        [_rightButton setImage:[UIImage imageNamed:@"choose"] forState: UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(ButtonRightClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
-(void)ButtonRightClick:(UIButton*)sender{
    [self Animation:self.rightButton.imageView andDre:self.buttonDre];
    if ([self.myPickView isFirstResponder]) {
        [self.myTextView resignFirstResponder];
    }
    if (self.buttonDre==YES) {
        [UIView animateWithDuration:0.5 animations:^{
            self.myPickView.frame=CGRectMake(100*XHSizeH,50*XHSizeH , XHScreenW-200*XHSizeW, 150*XHSizeH);
            self.textViewBottomView.frame=CGRectMake(0*XHSizeW, 220*XHSizeH, XHScreenW, XHScreenH);
        }];
        
    }else if (self.buttonDre==NO){
        [UIView animateWithDuration:0.5 animations:^{
            self.myPickView.frame=CGRectMake(100*XHSizeH,-300*XHSizeH , XHScreenW-200*XHSizeW, 150*XHSizeH);
            self.textViewBottomView.frame=CGRectMake(0*XHSizeW, 49*XHSizeH, XHScreenW,XHScreenH);
        }];
    }
    self.buttonDre=!self.buttonDre;
}
-(void)Animation:(UIView*)view andDre:(BOOL)dre{
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fillMode =kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration  = 0.5;
    animation.autoreverses = NO;
    if (dre==YES) {
        animation.fromValue=[NSNumber numberWithFloat:0.f];
        animation.toValue=[NSNumber numberWithFloat: M_PI /2];
    }else if (dre==NO){
        animation.fromValue=[NSNumber numberWithFloat: M_PI /2];
        animation.toValue=[NSNumber numberWithFloat:0.f];
    }
    animation.repeatCount =0; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [view.layer addAnimation:animation forKey:@"rotationAnimation"];
}
-(UILabel *)wordNumLabel{
    if (!_wordNumLabel) {
        _wordNumLabel=[[UILabel alloc] initWithFrame:CGRectMake(XHScreenW-100*XHSizeW, 230*XHSizeH,60*XHSizeW, 30*XHSizeH)];
        _wordNumLabel.textColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1];
        _wordNumLabel.backgroundColor=[UIColor clearColor];
        _wordNumLabel.font=[UIFont systemFontOfSize:12*XHSizeW];
        _wordNumLabel.textAlignment=NSTextAlignmentCenter;
        _wordNumLabel.text=[NSString stringWithFormat:@"%ld/%ld",self.stringText.length,self.wordNum];
    }
    return _wordNumLabel;
}
-(UIView *)textViewBottomView{
    if (!_textViewBottomView) {
        _textViewBottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 49*XHSizeH, XHScreenW, XHScreenH)];
        _textViewBottomView.backgroundColor=[UIColor colorWithHex:@"#EFEFEF" andColorAlpha:1];
        [_textViewBottomView addSubview:self.myTextView];
    }
    return _textViewBottomView;
}
-(UITextView *)myTextView{
    if (!_myTextView) {
        _myTextView=[[UITextView alloc] init];
        _myTextView.frame=CGRectMake(20*XHSizeW, 40*XHSizeH, XHScreenW-40*XHSizeW, 320*XHSizeH);
        _myTextView.layer.masksToBounds=YES;
        _myTextView.layer.cornerRadius=5;
        _myTextView.delegate=self;
        _myTextView.layer.borderColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0f].CGColor;
        _myTextView.font=[UIFont fontWithName:self.fontFimaly size:17];
        _myTextView.backgroundColor=[UIColor clearColor];
        _myTextView.layer.borderWidth=2;
        _myTextView.text=self.stringText;
        [_myTextView addSubview:self.wordNumLabel];
    }
    return _myTextView;
}

-(UIPickerView *)myPickView{
    if (!_myPickView) {
        _myPickView=[[UIPickerView alloc] init];
        _myPickView.frame=CGRectMake(100*XHSizeH,-300*XHSizeH , XHScreenW-200*XHSizeW, 150*XHSizeH);
        _myPickView.delegate=self;
        _myPickView.dataSource=self;
        _myPickView.userInteractionEnabled=YES;
    }
    return _myPickView;
}
-(void)pickViewTapGes:(UITapGestureRecognizer*)tap{
    [self.myTextView resignFirstResponder];
    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return XHScreenW-200*XHSizeW;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35*XHSizeH;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.wordStyleArray.count;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.myTextView resignFirstResponder];
    if (row==0) {
        self.myTextView.font=[UIFont fontWithName:@"FZFSJW--GB1-0" size:17];
        self.fontFimaly=@"FZFSJW--GB1-0";
    }else if (row==1){
       self.myTextView.font=[UIFont fontWithName:@"FZKTJW--GB1-0" size:17];
        self.fontFimaly=@"FZKTJW--GB1-0";
    }else if (row==2){
        self.myTextView.font=[UIFont fontWithName:@"FZSSJW--GB1-0" size:17];
        self.fontFimaly=@"FZSSJW--GB1-0";
    }else if (row==3){
        self.myTextView.font=[UIFont fontWithName:@"HYJinKaiJ" size:17];
        self.fontFimaly=@"HYJinKaiJ";
    }else if (row==4){
        self.myTextView.font=[UIFont fontWithName:@"HYa5gf" size:17];
        self.fontFimaly=@"HYa5gf";
    }else if (row==5){
        self.myTextView.font=[UIFont fontWithName:@"PingFangSC-Regular" size:17];
        self.fontFimaly=@"PingFangSC-Regular";
    }
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (self.buttonDre==NO){
        [UIView animateWithDuration:0.5 animations:^{
            self.myPickView.frame=CGRectMake(100*XHSizeH,-300*XHSizeH , XHScreenW-200*XHSizeW, 150*XHSizeH);
            self.textViewBottomView.frame=CGRectMake(0*XHSizeW, 49*XHSizeH, XHScreenW,XHScreenH);
        }];
        [self Animation:self.rightButton.imageView andDre:self.buttonDre];
         self.buttonDre=!self.buttonDre;
    }
    if ([self.stringText isEqualToString:@" 标题"]||[self.stringText isEqualToString:@"标题"]||[self.stringText isEqualToString:@"点击输入内容"]||[self.stringText isEqualToString:@"作者"]||[self.stringText isEqualToString:@" 作者"]||[self.stringText isEqualToString:@" 点击输入内容"]) {
        textView.text=@"";
    }
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    self.wordNumLabel.text=[NSString stringWithFormat:@"%ld/%@",textView.text.length,[NSString stringWithFormat:@"%ld",self.wordNum]];
    NSArray*lineArray=[textView.text componentsSeparatedByString:@"\n"];
    if(textView.text.length>=self.wordNum||lineArray.count>=11){
        return NO;
    }else{
       return YES;
    }
    
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(100, 0,XHScreenW-200*XHSizeW , 35*XHSizeH)];
    label.textAlignment=NSTextAlignmentCenter;
    if (row==0) {
        label.font=[UIFont fontWithName:@"FZFSJW--GB1-0" size:17];
    }else if (row==1){
        label.font=[UIFont fontWithName:@"FZKTJW--GB1-0" size:17];
    }else if (row==2){
        label.font=[UIFont fontWithName:@"FZSSJW--GB1-0" size:17];
    }else if (row==3){
        label.font=[UIFont fontWithName:@"HYJinKaiJ" size:17];
    }else if (row==4){
        label.font=[UIFont fontWithName:@"HYa5gf" size:17];
    }else if (row==5){
        label.font=[UIFont fontWithName:@"PingFangSC-Regular" size:17];
    }
    [self clearSpearatorLine];
        label.text=self.wordStyleArray[row];
    return label;
}
- (void)clearSpearatorLine
{
    [self.myPickView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.frame.size.height < 1)
        {
            [obj setBackgroundColor:[UIColor clearColor]];
        }
    }];
}

-(void)leftBackButtonClick:(UIBarButtonItem*)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        self.stringBlock(self.myTextView.text,self.fontFimaly);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
