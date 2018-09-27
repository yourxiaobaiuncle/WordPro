//
//  ShowImageViewController.m
//  word
//
//  Created by 信和财富 on 2018/1/30.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import "ShowImageViewController.h"
#import "XWInteractiveTransition.h"
#import "XWPresentOneTransition.h"
#import <UShareUI/UShareUI.h>
@interface ShowImageViewController ()<UIViewControllerTransitioningDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) XWInteractiveTransition *interactiveDismiss;
@property (nonatomic, strong) XWInteractiveTransition *interactivePush;
@property(nonatomic,strong)UICollectionView*myCollectionView;
@property(nonatomic,retain)NSMutableArray*dataArray;
@end

@implementation ShowImageViewController
-(instancetype)init{
    if (self=[super init]) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"homeAddBackBlackView" object:nil];
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor colorWithHex:@"#EFEFEF" andColorAlpha:1];
    [self setUpUI];
    // Do any additional setup after loading the view.
}
-(void)setUpUI{
    UIImageView*imageView=[[UIImageView alloc] initWithImage:self.image];
    imageView.frame=CGRectMake(10*XHSizeW, 54*XHSizeH, 355*XHSizeW, 355*XHSizeW);
    [self.view addSubview:imageView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setTitle:@"dismiss" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"getIt"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    button.frame=CGRectMake(XHScreenW/2-20*XHSizeW, 10*XHSizeH, 40*XHSizeW, 30*XHSizeH);
    [self.view addSubview:self.myCollectionView];
    //self.interactiveDismiss = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypeDismiss GestureDirection:XWInteractiveTransitionGestureDirectionDown];
    //[self.interactiveDismiss addPanGestureForViewController:self];
}
-(UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout*flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        _myCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 427*XHSizeW, XHScreenW, 65*XHSizeH) collectionViewLayout:flowLayout];
        _myCollectionView.backgroundColor=[UIColor colorWithHex:@"#EFEFEF" andColorAlpha:1];
        _myCollectionView.dataSource=self;
        _myCollectionView.delegate=self;
        _myCollectionView.showsHorizontalScrollIndicator=NO;
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
    imageView.image=[UIImage imageNamed:self.dataArray[indexPath.row]];
    //    }
    [cell.contentView addSubview:imageView];
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(30*XHSizeH, 20*XHSizeW, 44*XHSizeH, 20*XHSizeW);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
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
    [shareObject setShareImage:self.image];
    
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
        _dataArray=[NSMutableArray arrayWithArray:@[@"friendCirleImageShare",@"weChatImageShare",@"QQImageShare",@"qozeImageShare",@"sinaImageShare"]];
    }
    return _dataArray;
}
- (void)dismiss{
    if (_delegate && [_delegate respondsToSelector:@selector(presentedOneControllerPressedDissmiss)]) {
        [_delegate presentedOneControllerPressedDissmiss];
    }
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [XWPresentOneTransition transitionWithTransitionType:XWPresentOneTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [XWPresentOneTransition transitionWithTransitionType:XWPresentOneTransitionTypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveDismiss.interation ? _interactiveDismiss : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    XWInteractiveTransition *interactivePresent = [_delegate interactiveTransitionForPresent];
    return interactivePresent.interation ? interactivePresent : nil;
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
