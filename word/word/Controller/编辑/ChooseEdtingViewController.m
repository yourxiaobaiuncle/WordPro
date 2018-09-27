
//
//  ChooseEdtingViewController.m
//  word
//
//  Created by 信和财富 on 2018/1/22.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import "ChooseEdtingViewController.h"
#import "EdtingModelView.h"
#import "InPutViewController.h"
#import "SharePicViewController.h"
#import <Photos/PHPhotoLibrary.h>
#import <Photos/PHAssetChangeRequest.h>
#import "SView.h"
@interface ChooseEdtingViewController ()<EdtingModelViewDelegete>
@property(nonatomic,strong)UIButton*rightButton;
@end

@implementation ChooseEdtingViewController
-(void)tapGesClickDelegete:(UITapGestureRecognizer *)sender andTextViewString:(NSString *)textViewString andWordNum:(NSInteger)wordNum andFontFimaly:(NSString *)fontFimaly{
    InPutViewController*inPut=[[InPutViewController alloc] init];
    inPut.stringText=textViewString;
    inPut.wordNum=wordNum;
    inPut.fontFimaly=fontFimaly;
    UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:inPut];
    inPut.stringBlock = ^(NSString *returnString,NSString*fontFimaly) {
        NSInteger tag=sender.view.tag;
        NSDictionary*dict=@{@"tag":[NSString stringWithFormat:@"%ld",tag],@"text":returnString,@"fontFimaly":fontFimaly};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getStringFromEdtingView" object:dict];
    } ;
    [self presentViewController:nav animated:YES completion:nil];
}
-(instancetype)initWithEdtingViewWithViewFrame:(CGRect)viewFrame andLabelFrame:(CGRect)labelFrame andTitleFrame:(CGRect)titleFrame andWordViewModelTypr:(ChooseEdtingModelType)modelType{
    if (self=[super init]) {
        EdtingModelView*edtingModelView=[[EdtingModelView alloc] initEdtingViewWithViewFrame:CGRectMake(10*XHSizeW, 117*XHSizeH, 355*XHSizeW, 355*XHSizeH) andLabelFrame:CGRectMake(43*XHSizeW,62*XHSizeH ,269*XHSizeW ,136*XHSizeH) andTitleFrame:CGRectMake(104*XHSizeW,308*XHSizeH,148*XHSizeW,20*XHSizeH) andWordViewModelTypr:modelType];
        edtingModelView.delegete=self;
        [self.view addSubview:edtingModelView];       
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithHex:@"#F5F5F5" andColorAlpha:1.0f];
    UIBarButtonItem*leftButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftBack"] style:0 target:self action:@selector(leftBackButtonClick:)];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
     self.title=@"编辑字签";
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar addSubview:self.rightButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.rightButton removeFromSuperview];
    self.rightButton=nil;
}
-(void)leftBackButtonClick:(UIBarButtonItem*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame=CGRectMake(XHScreenW-60, 10, 50, 30);
        //_rightButton.backgroundColor=[UIColor whiteColor];
        //_rightButton.layer.borderColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1].CGColor;
        [_rightButton setImage:[UIImage imageNamed:@"keep"] forState: UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(ButtonRightClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
-(void)ButtonRightClick:(UIButton*)sender{
    for (UIView*view in self.view.subviews) {
        if ([view isKindOfClass:[EdtingModelView class]]) {
            BOOL isPic=YES;
            for (UIView*vi in view.subviews) {
                if ([vi isKindOfClass:[SView class]]) {
                    SView*sv=(SView*)vi;
                    if ([sv.string isEqualToString:@" 点击输入内容"]||((sv.tag==model1Text||sv.tag==model2Text)&&sv.string.length==0)){
                        isPic=NO;
                        [self creatAlertView];
                        break;
                    }
                    if (sv.string.length==0||[sv.string isEqualToString:@" 点击输入内容"]||[sv.string isEqualToString:@" 标题"]||[sv.string isEqualToString:@" 作者"]) {
                        isPic=NO;
                        [self creatAlertViewController:view];
                        break;
                    }
                }else if ([vi isKindOfClass:[UILabel class]]){
                    UILabel*label=(UILabel *)vi;
                    if ([label.text isEqualToString:@"点击输入内容"]||((label.tag==model3Text||label.tag==model4Text)&&label.text.length==0)) {
                         isPic=NO;
                        [self creatAlertView];
                        break;
                    }
                    if (label.text.length==0||[label.text isEqualToString:@"点击输入内容"]||[label.text isEqualToString:@"标题"]||[label.text isEqualToString:@"作者"]) {
                        isPic=NO;
                        [self creatAlertViewController:view];
                        break;
                    }
                }
            }
            if (isPic==YES) {
                [self creatPic:view];
            }
        }
    }
}
-(void)creatAlertView{
    UIAlertController*alertVC=[[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"编辑内容为空,请重新编辑" preferredStyle:UIAlertControllerStyleAlert] init];
    UIAlertAction*leftAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:leftAction];
    [self presentViewController:alertVC animated:YES completion:^{
    }];
}
-(void)creatAlertViewController:(UIView*)view{
    UIAlertController*alertVC=[[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"部分输入内容为空,是否重新编辑" preferredStyle:UIAlertControllerStyleAlert] init];
    UIAlertAction*leftAction=[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction*rightAction=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self creatPic:view];
    }];
    [alertVC addAction:leftAction];
    [alertVC addAction:rightAction];
    [self presentViewController:alertVC animated:YES completion:^{
    }];
}
-(void)creatPic:(UIView*)view{
    UIImage*image=[WordTool clicpPictureViewWithRect:CGRectMake(0*XHSizeW, 0*XHSizeH, 353*XHSizeW, 353*XHSizeH) andClicpView:view];
    SharePicViewController*sharePic=[[SharePicViewController alloc] init];
    sharePic.myImage=image;
    if ([WordTool isSavePic]==YES) {
        dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
        dispatch_async(queue, ^{
            if ([image isKindOfClass:[NSNull class]]) {
                return;
            }
            NSArray*array=[[NSUserDefaults standardUserDefaults] valueForKey:@"picData"];
            if ([array isKindOfClass:[NSNull class]]&&array.count==0) {
                NSMutableArray*dataArray=[[NSMutableArray alloc] init];
                [dataArray insertObject:UIImagePNGRepresentation(image) atIndex:0];
                NSArray*arr=dataArray;
                [[NSUserDefaults standardUserDefaults] setValue: arr forKey:@"picData"];
            }else{
                NSMutableArray*arr=[NSMutableArray arrayWithArray:array];
                [arr insertObject:UIImagePNGRepresentation(image) atIndex:0];
                NSArray*a=arr;
                [[NSUserDefaults standardUserDefaults] setValue:a forKey:@"picData"];
            }
        });
    }
    
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"savePicToPhotoAlbum"] isEqualToString:@"0"]&&![[[NSUserDefaults standardUserDefaults] valueForKey:@"savePicToPhotoAlbum"] isEqualToString:@"1"]) {
        UIAlertController*alertVC=[[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否将生成图片保存到相册" preferredStyle:UIAlertControllerStyleAlert] init];
        UIAlertAction*leftAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"savePicToPhotoAlbum"];
        }];
        UIAlertAction*rightAction=[UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"savePicToPhotoAlbum"];
            [self loadImageFinished:image];
        }];
        [alertVC addAction:leftAction];
        [alertVC addAction:rightAction];
        [self presentViewController:alertVC animated:YES completion:^{
        }];
    }else{
        if ([WordTool isSavePicToPhotoAlbum]) {
            [self loadImageFinished:image];
        }
    }
    [self.navigationController pushViewController:sharePic animated:YES];
}
- (void)loadImageFinished:(UIImage *)image
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"success = %d, error = %@", success, error);
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
