//
//  HomeViewController.m
//  word
//
//  Created by Mac on 2017/12/25.
//  Copyright © 2017年 xinHeYanJunYuan. All rights reserved.
//

#import "HomeViewController.h"
#import "EdtingViewController.h"
#import "XWInteractiveTransition.h"
#import "SettingViewController.h"
#import "ShowImageViewController.h"
#import "XWInteractiveTransition.h"
#import "XWPresentOneTransition.h"
#import "MJRefresh.h"
@interface HomeViewController ()<WordPresentedOneControllerDelegete,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,XWPresentedOneControllerDelegate>
@property (nonatomic, strong) XWInteractiveTransition *interactivePush;
@property(nonatomic,strong)UIView*backView;
@property(nonatomic,strong)UICollectionView*myCollectionView;
@property(nonatomic,retain)NSMutableArray*dataArray;
@property(nonatomic,strong)UIView*showImageView;
@property(nonatomic,strong)UIButton*addButton;
@end
@implementation HomeViewController
-(NSArray*)checkImage{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"picData"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    UIBarButtonItem*barButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:0 target:self action:@selector(barButtonRightItem:)];
    self.navigationItem.rightBarButtonItem=barButton;
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
    self.title=@"字签";
    self.view.backgroundColor=[UIColor colorWithHex:@"#F5F5F5" andColorAlpha:1.0];
    // Do any additional setup after loading the view.
    [self creatUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addBackBlackView:) name:@"homeAddBackBlackView" object:nil];
}
-(void)addBackBlackView:(NSNotification*)sender{
    UIView*backView=[[UIView alloc] initWithFrame:self.view.bounds];
    backView.tag=10000000;
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha=0.4;
    [self.view addSubview:backView];
}
-(void)creatUI{
    if (![self checkImage]||[[self checkImage] count]==0) {
        if (_myCollectionView) {
            [self.myCollectionView removeFromSuperview];
            self.myCollectionView=nil;
            [self.view addSubview:self.backView];
        }else{
            [self.view addSubview:self.backView];
        }
    }else{
        self.dataArray=[NSMutableArray arrayWithArray:[self checkImage]];
        if (self.backView) {
            [self.backView removeFromSuperview];
            self.backView=nil;
            [self.view addSubview:self.myCollectionView];
        }else{
            [self.view addSubview:self.myCollectionView];
        }
    }
    [self.view addSubview:self.addButton];
}
-(void)reloadCollection{
    self.dataArray=[NSMutableArray arrayWithArray:[self checkImage]];
    if (!_myCollectionView) {
        if (self.backView) {
            [self.backView removeFromSuperview];
            self.backView=nil;
        }
        [self.view addSubview:self.myCollectionView];

    }else{
         [self.myCollectionView reloadData];
    }
    [self.view bringSubviewToFront:self.addButton];
}
-(UIButton *)addButton{
    if (!_addButton) {
        _addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame=CGRectMake(158*XHSizeW,554*XHSizeW , 60, 60);
        _addButton.layer.masksToBounds=YES;
        _addButton.layer.cornerRadius=30;
        [_addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:_addButton];
    }
    return _addButton;
}
-(UIView *)backView{
    if (!_backView) {
        _backView=[[UIView alloc] initWithFrame:CGRectMake(0, 0*XHSizeH, XHScreenW, XHScreenH)];
        UIImageView*imageView=[[UIImageView alloc] initWithFrame:CGRectMake(111*XHSizeW, 154*XHSizeH, 163*XHSizeW, 151*XHSizeH)];
        imageView.image=[UIImage imageNamed:@"Group 2"];
        [_backView addSubview:imageView];
        _backView.userInteractionEnabled=YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCollection) name:@"keepImageBackHome" object:nil];
    }
    return _backView;
}
-(UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout*flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        _myCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, XHScreenW,XHScreenH) collectionViewLayout:flowLayout];
        _myCollectionView.backgroundColor=[UIColor colorWithHex:@"#F5F5F5" andColorAlpha:1.0];
        _myCollectionView.dataSource=self;
        _myCollectionView.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(CollectionViewReload)];
        UIImageView*imageView=[[UIImageView alloc] initWithFrame:CGRectMake(XHScreenW/2-97*XHSizeW,15*XHSizeH ,194*XHSizeW,23*XHSizeH)];
        imageView.image=[UIImage imageNamed:@"cloud"];
//        UIImageView*imageViewLeftCloud=[[UIImageView alloc] initWithFrame:CGRectMake(-43*XHSizeW,7*XHSizeH ,87*XHSizeW,42*XHSizeH)];
//        imageViewLeftCloud.image=[UIImage imageNamed:@"cloud"];
//        UIImageView*imageViewRightCloud=[[UIImageView alloc] initWithFrame:CGRectMake(XHScreenW-43*XHSizeW,7*XHSizeH ,87*XHSizeW,42*XHSizeH)];
//        imageViewRightCloud.image=[UIImage imageNamed:@"cloud"];
        [_myCollectionView.mj_header addSubview:imageView];
        //[_myCollectionView.mj_header addSubview:imageViewLeftCloud];
        //[_myCollectionView.mj_header addSubview:imageViewRightCloud];
        //[_myCollectionView.backgroundView addSubview:imageView];
        _myCollectionView.userInteractionEnabled=YES;
        _myCollectionView.delegate=self;
        [_myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
        _myCollectionView.userInteractionEnabled=YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCollection) name:@"keepImageBackHome" object:nil];
    }
    return _myCollectionView;
}
-(void)CollectionViewReload{
    [self.myCollectionView reloadData];
    [self.myCollectionView.mj_header endRefreshing];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataArray.count==0) {
        if(_myCollectionView){
            [self.myCollectionView removeFromSuperview];
            self.myCollectionView=nil;
        }
        if (_backView) {
            [self.backView removeFromSuperview];
            self.backView=nil;
        }
        [self.view addSubview:self.backView];
        [self.view bringSubviewToFront:self.addButton];
    }
    return self.dataArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(XHScreenW/2-28*XHSizeW, XHScreenW/2-28*XHSizeW);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell*cell=[self.myCollectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    if(cell){
        for (UIView*view in  cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0*XHSizeW, 0*XHSizeH, XHScreenW/2-40*XHSizeW, XHScreenW/2-40*XHSizeW)];
    imageView.image=[UIImage imageWithData:self.dataArray[indexPath.row]];
    imageView.userInteractionEnabled=YES;
    UILongPressGestureRecognizer*longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
    [imageView addGestureRecognizer:longPress];
    UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewButtonClick:)];
    [imageView addGestureRecognizer:tapGesture];
    imageView.tag=1000+indexPath.row;
    imageView.layer.masksToBounds=YES;
    imageView.layer.cornerRadius=5;
    
    [cell.contentView addSubview:imageView];
    return cell;
}
-(void)longPressClick:(UILongPressGestureRecognizer*)sender{
    UIImageView*imageView=(UIImageView*)sender.view;
    UIView*viewBack=[[UIView alloc] initWithFrame:imageView.bounds];
    viewBack.backgroundColor=[UIColor colorWithWhite:0 alpha:0.2];
    [imageView addSubview:viewBack];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake((XHScreenW/2-40*XHSizeW)/2-30, (XHScreenW/2-40*XHSizeW)/2-30, 60, 60);
    button.layer.masksToBounds=YES;
    button.tag=imageView.tag-1000+100;
    button.backgroundColor=mainColor;
    [button setImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(delButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius=30;
    [viewBack addSubview:button];
    for (int m=0; m<self.dataArray.count; m++) {

        [sender.view removeGestureRecognizer:sender];
    }
}
-(void)delButtonClick:(UIButton*)sender{
    [self.dataArray removeObjectAtIndex:sender.tag-100];
    NSArray*arr=self.dataArray;
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"picData"];
        [self.myCollectionView reloadData];
    for (int m=0; m<self.dataArray.count; m++) {
        UICollectionViewCell*cell=[self.myCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:m inSection:0]];
        UIImageView*imageView=[cell.contentView viewWithTag:1000+m];
        UILongPressGestureRecognizer*longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
        [imageView addGestureRecognizer:longPress];
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20*XHSizeH, 20*XHSizeW, 20*XHSizeH, 20*XHSizeW);
}
-(void)imageViewButtonClick:(UITapGestureRecognizer*)sender{
    [self presentImageViewShow:self.dataArray[sender.view.tag-1000]];
    _interactivePush = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypePresent GestureDirection:XWInteractiveTransitionGestureDirectionUp];
    typeof(self)weakSelf = self;
    _interactivePush.presentConifg = ^(){
        [weakSelf presentImageViewShow:weakSelf.dataArray[sender.view.tag-1000]];
    };
    [_interactivePush addPanGestureForViewController:self.navigationController];
}
- (void)presentImageViewShow:(NSData*)DataImage{
    ShowImageViewController *presentedVC = [ShowImageViewController new];
    presentedVC.image=[UIImage imageWithData:DataImage];
    presentedVC.delegate=self;
    [self presentViewController:presentedVC animated:YES completion:nil];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (void)present{
    EdtingViewController*edtingVC=[[EdtingViewController alloc] init];
    [self.navigationController pushViewController:edtingVC animated:YES];
}
-(void)addButtonClick:(UIButton*)sender{
   EdtingViewController*edtingVC=[[EdtingViewController alloc] init];

    [self presentViewController:edtingVC animated:YES completion:nil];
}
-(void)barButtonRightItem:(UIBarButtonItem*)sender{
    [self.navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];
}
- (void)presentedOneControllerPressedDissmiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent{
    return _interactivePush;
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
