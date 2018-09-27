//
//  EdtingViewController.m
//  word
//
//  Created by Mac on 2017/12/25.
//  Copyright © 2017年 xinHeYanJunYuan. All rights reserved.
//

#import "EdtingViewController.h"
#import <objc/runtime.h>
#import "XWInteractiveTransition.h"
#import "EdtingView.h"
#import "EdtingModelView.h"
#import "InPutViewController.h"
#import "ChooseEdtingViewController.h"
@interface EdtingViewController ()<UIViewControllerTransitioningDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView*myCollectionView;
@property(nonatomic) UIControlContentVerticalAlignment contentVerticalAlignment;
@property(nonatomic) UIControlContentHorizontalAlignment contentHorizontalAlignment;
@property(nonatomic,retain)NSMutableArray*dataArray;
@property(nonatomic,retain)NSMutableArray*imageNoSelectedDataArray;
@property(nonatomic,retain)UIButton*buttonModelImageView;
@end
@implementation EdtingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem*leftButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftBack"] style:0 target:self action:@selector(leftBackButtonClick:)];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
    self.view.backgroundColor=[UIColor colorWithHex:@"F5F5F5" andColorAlpha:1.0];
    self.title=@"字签模板";
    [self creatUIWithModelViewType:model11];
    [self.view addSubview:self.myCollectionView];
}
-(void)leftBackButtonClick:(UIBarButtonItem*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout*flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        _myCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 576*XHSizeW, XHScreenW, 92*XHSizeH) collectionViewLayout:flowLayout];
        _myCollectionView.backgroundColor=[UIColor colorWithHex:@"#EFEFEF" andColorAlpha:1.0];
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
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    imageView.tag=1000;
    if (indexPath.row==0) {
         imageView.image=[UIImage imageNamed:self.imageNoSelectedDataArray[indexPath.row]];
    }else{
         imageView.image=[UIImage imageNamed:self.dataArray[indexPath.row]];
    }
    [cell.contentView addSubview:imageView];
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(40*XHSizeH, 20*XHSizeW, 44*XHSizeH, 20*XHSizeW);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    for (int m=0 ;m<self.dataArray.count;m++) {
        UICollectionViewCell*Cell=[self.myCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:m inSection:0]];
        UIImageView*imageView=[Cell.contentView viewWithTag:1000];
        imageView.image=[UIImage imageNamed:self.dataArray[m]];
    }
    UICollectionViewCell*Cell=[self.myCollectionView cellForItemAtIndexPath:indexPath];
    UIImageView*imageView=[Cell.contentView viewWithTag:1000];
    imageView.image=[UIImage imageNamed:self.imageNoSelectedDataArray[indexPath.row]];
    if (indexPath.row==0) {
        [self creatUIWithModelViewType:model11];
    }else if (indexPath.row==1){
        [self creatUIWithModelViewType:model22];
    }else if (indexPath.row==2){
        [self creatUIWithModelViewType:model33];
    }else if (indexPath.row==3){
        [self creatUIWithModelViewType:model44];
    }
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray arrayWithArray:@[@"model2NC",@"model1NC",@"model3NC",@"model4NC"]];
    }
    return _dataArray;
}
-(NSMutableArray *)imageNoSelectedDataArray{
    if (!_imageNoSelectedDataArray) {
        _imageNoSelectedDataArray=[NSMutableArray arrayWithArray:@[@"model2",@"model1",@"model3",@"model4"]];
    }
    return _imageNoSelectedDataArray;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 30*XHSizeW;
}

-(void)creatUIWithModelViewType:(WordViewModelType)modelType{
    switch (modelType) {
        case 1:
            [self.buttonModelImageView setImage:[UIImage imageNamed:@"modelShow"] forState:UIControlStateNormal];
            break;
        case 0:
            [self.buttonModelImageView setImage:[UIImage imageNamed:@"modelView2"] forState:UIControlStateNormal];
            break;
        case 2:
            [self.buttonModelImageView setImage:[UIImage imageNamed:@"modelView3"] forState:UIControlStateNormal];
            break;
        case 3:
            [self.buttonModelImageView setImage:[UIImage imageNamed:@"modelView4"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
     self.buttonModelImageView.tag=modelType;
}
-(UIButton *)buttonModelImageView{
    if (!_buttonModelImageView) {
        _buttonModelImageView=[UIButton buttonWithType:UIButtonTypeCustom];
        _buttonModelImageView.tag=10000;
        _buttonModelImageView.frame=CGRectMake(10*XHSizeW, 117*XHSizeH, 355*XHSizeW, 355*XHSizeH);
        _buttonModelImageView.adjustsImageWhenHighlighted=NO;
        [_buttonModelImageView addTarget:self action:@selector(buttonModelImageView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_buttonModelImageView];
    }
    return _buttonModelImageView;
}
-(void)buttonModelImageView:(UIButton*)sender{
        if (sender.tag==model11) {
            ChooseEdtingViewController*ChooseEdtingView=[[ChooseEdtingViewController alloc] initWithEdtingViewWithViewFrame:CGRectMake(10*XHSizeW, 117*XHSizeH, 355*XHSizeW, 355*XHSizeH) andLabelFrame:CGRectMake(43*XHSizeW,62*XHSizeH ,269*XHSizeW ,136*XHSizeH) andTitleFrame:CGRectMake(104*XHSizeW,308*XHSizeH,148*XHSizeW,20*XHSizeH) andWordViewModelTypr:sender.tag];
           // ChooseEdtingView.delegete=self;
            [self.navigationController pushViewController:ChooseEdtingView animated:YES];
        }else if (sender.tag==model22){
            ChooseEdtingViewController*ChooseEdtingView=[[ChooseEdtingViewController alloc] initWithEdtingViewWithViewFrame:CGRectMake(10*XHSizeW, 117*XHSizeH, 355*XHSizeW, 355*XHSizeH) andLabelFrame:CGRectMake(43*XHSizeW,62*XHSizeH ,29*XHSizeW ,136*XHSizeH) andTitleFrame:CGRectMake(104*XHSizeW,308*XHSizeH,148*XHSizeW,20*XHSizeH) andWordViewModelTypr:sender.tag];
            [self.navigationController pushViewController:ChooseEdtingView animated:YES];
        }else if (sender.tag==model33){
            ChooseEdtingViewController*ChooseEdtingView=[[ChooseEdtingViewController alloc] initWithEdtingViewWithViewFrame:CGRectMake(10*XHSizeW, 117*XHSizeH, 355*XHSizeW, 355*XHSizeH) andLabelFrame:CGRectMake(43*XHSizeW,62*XHSizeH ,269*XHSizeW ,156*XHSizeH) andTitleFrame:CGRectMake(104*XHSizeW,308*XHSizeH,148*XHSizeW,20*XHSizeH) andWordViewModelTypr:sender.tag];
           [self.navigationController pushViewController:ChooseEdtingView animated:YES];
        }else if (sender.tag==model44){
            ChooseEdtingViewController*ChooseEdtingView=[[ChooseEdtingViewController alloc] initWithEdtingViewWithViewFrame:CGRectMake(10*XHSizeW, 117*XHSizeH, 355*XHSizeW, 269*XHSizeH) andLabelFrame:CGRectMake(18*XHSizeW,20*XHSizeH ,209*XHSizeW ,200*XHSizeH) andTitleFrame:CGRectMake(123*XHSizeW,231*XHSizeH,105*XHSizeW,20*XHSizeH) andWordViewModelTypr:sender.tag];
            [self.navigationController pushViewController:ChooseEdtingView animated:YES];
        }
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
