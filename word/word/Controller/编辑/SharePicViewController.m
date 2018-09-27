//
//  SharePicViewController.m
//  word
//
//  Created by 信和财富 on 2018/1/25.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import "SharePicViewController.h"
#import <UShareUI/UShareUI.h>
@interface SharePicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UIImageView*imageView;
@property(nonatomic,strong)UICollectionView*myCollectionView;
@property(nonatomic,retain)NSMutableArray*dataArray;
@property(nonatomic,strong)UIView*backView;
//@property(non)
@end

@implementation SharePicViewController

-(void)viewWillDisappear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    for (UIView*view in self.navigationController.navigationBar.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    self.navigationController.navigationBar.barTintColor=mainColor;
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(XHScreenW/2-40*XHSizeW,0*XHSizeH, 80*XHSizeW, 40*XHSizeH);
    button.backgroundColor=[UIColor clearColor];
    button.tag=1000;
    [button setTitle:@"再做一张" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:button];
    //[self.navigationController.navigationBar addSubview:viewBar];
    self.view.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.imageView];
    [self.backView addSubview:self.myCollectionView];
    self.view.backgroundColor=mainColor;
    // Do any additional setup after loading the view.
}
-(void)buttonClick:(UIButton*)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"keepImageBackHome" object:nil];
    UIButton*button=[self.navigationController.navigationBar viewWithTag:1000];
    [button removeFromSuperview];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout*flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        _myCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 537*XHSizeW, XHScreenW, 82*XHSizeH) collectionViewLayout:flowLayout];
        _myCollectionView.backgroundColor=[UIColor colorWithHex:@"#373737" andColorAlpha:1.0];
        _myCollectionView.dataSource=self;
        _myCollectionView.delegate=self;
        [_myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    }
    return _myCollectionView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(60*XHSizeW, 60*XHSizeW);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell*cell=[self.myCollectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10*XHSizeW, 20*XHSizeH, 35*XHSizeW, 35*XHSizeH)];
//    if (indexPath.row==0) {
//        imageView.image=[UIImage imageNamed:self.imageNoSelectedDataArray[indexPath.row]];
//    }else{

    imageView.image=[UIImage imageNamed:self.dataArray[indexPath.row]];
//    }
    [cell.contentView addSubview:imageView];
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(30*XHSizeH, 20*XHSizeW, 44*XHSizeH, 20*XHSizeW);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        
        //显示分享面板
        //    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //        // 根据获取的platformType确定所选平台进行下一步操作
        //    }];
        if (indexPath.row==0) {
            [self shareTo:UMSocialPlatformType_WechatTimeLine];
            
        }else if (indexPath.row==1) {
            [self shareTo:UMSocialPlatformType_WechatSession];
            
        }else if (indexPath.row==2) {
            [self shareTo:UMSocialPlatformType_QQ];
            
        }
        else if (indexPath.row==3) {
            [self shareTo:UMSocialPlatformType_Qzone];
            
        }
        else if (indexPath.row==4) {
            [self shareTo:UMSocialPlatformType_Sina];
            
        }
        else if (indexPath.row==5) {
            
        }
}
-(void)shareTo:(UMSocialPlatformType)socialPlatformType{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"AppIcon"];
    [shareObject setShareImage:self.myImage];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:socialPlatformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            
        }else{
            
        }
    }];
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray arrayWithArray:@[@"friendCirel",@"shareWeChat",@"QQ",@"quze",@"weibo"]];
    }
    return _dataArray;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10*XHSizeW, 117*XHSizeH, 355*XHSizeW, 355*XHSizeH)];
        _imageView.layer.masksToBounds=YES;
        _imageView.layer.cornerRadius=3;
        _imageView.image=self.myImage;
    }
    return _imageView;
}
-(UIView *)backView{
    if (!_backView) {
        _backView=[[UIView alloc] initWithFrame:CGRectMake(0, 49*XHSizeH, XHScreenW, XHScreenH-69*XHSizeH)];
        _backView.backgroundColor=[UIColor blackColor];
        _backView.userInteractionEnabled=YES;
    }
    return _backView;
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
