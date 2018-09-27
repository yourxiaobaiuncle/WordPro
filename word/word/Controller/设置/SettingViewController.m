//
//  SettingViewController.m
//  word
//
//  Created by Mac on 2018/1/10.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingFirstTableViewCell.h"
#import "SettingSecondTableViewCell.h"
#import "AboutMeViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*myTableView;
@end

@implementation SettingViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.tintColor=[UIColor colorWithHex:@"#FEFEFE" andColorAlpha:1.0];
    UIBarButtonItem*leftButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftBack"] style:0 target:self action:@selector(leftBackButtonClick:)];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
}
-(void)leftBackButtonClick:(UIBarButtonItem*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    self.view.backgroundColor=[UIColor colorWithHex:@"#F5F5F5" andColorAlpha:1.0];
    _myTableView=({
        UITableView*tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor=[UIColor colorWithHex:@"#F5F5F5" andColorAlpha:1.0];
        tableView.dataSource=self;
        tableView.delegate=self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
        [self.view addSubview:tableView];
        tableView.scrollEnabled=NO;
        UIView*view=[[UIView alloc] initWithFrame:CGRectZero];
        //view.backgroundColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
        tableView.tableFooterView=view;
       // tableView.tableHeaderView.tintColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
        tableView;
    });
    
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else if (section==1){
        return 1;
    }else{
        return 2;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView*view=[[UIView alloc] initWithFrame:tableView.tableHeaderView.frame];

    UIView*viewTop=[[UIView alloc] initWithFrame:CGRectMake(0, 0, XHScreenW, 0.5*XHSizeH)];
    viewTop.backgroundColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1];
    [view addSubview:viewTop];
    UIView*viewBottom=[[UIView alloc] initWithFrame:CGRectMake(0, 12.5*XHSizeH, XHScreenW, 0.5*XHSizeH)];
    viewBottom.backgroundColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1];
    [view addSubview:viewBottom];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==2) {
        UIView*view=[[UIView alloc] initWithFrame:tableView.tableHeaderView.frame];
        UIView*viewBottom=[[UIView alloc] initWithFrame:CGRectMake(0,0*XHSizeH, XHScreenW, 0.5*XHSizeH)];
        viewBottom.backgroundColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:1];
        [view addSubview:viewBottom];
        return view;
    }
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*XHSizeH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 13*XHSizeH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return 0.5*XHSizeH;
    }else{
        return 0;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1&&indexPath.section==2) {
        [self.navigationController pushViewController:[[AboutMeViewController alloc] init] animated:YES];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell*cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCell"];
    if (indexPath.section==0) {
        SettingFirstTableViewCell*cell=[[SettingFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UIAccessibilityTraitNone;
        cell.MySwich.tag=100+indexPath.row;
        cell.backgroundColor=[UIColor colorWithHex:@"FFFFFF" andColorAlpha:1.0];
        if (indexPath.row==0) {
            cell.leftLable.text=@"保存拍摄原图";
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"savePic"] isEqualToString:@"1"]) {
                cell.MySwich.on=YES;
            }else if([[[NSUserDefaults standardUserDefaults] valueForKey:@"savePic"] isEqualToString:@"0"]){
                cell.MySwich.on=NO;
            }
        }else if (indexPath.row==1){
            cell.leftLable.text=@"保存字签到相册";
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"savePicToPhotoAlbum"] isEqualToString:@"1"]) {
                cell.MySwich.on=YES;
            }else if([[[NSUserDefaults standardUserDefaults] valueForKey:@"savePicToPhotoAlbum"] isEqualToString:@"0"]){
                cell.MySwich.on=NO;
            }
        }
        return cell;
    }else{
        SettingSecondTableViewCell*cell=[[SettingSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"secoredCell"];
        cell.backgroundColor=[UIColor colorWithHex:@"FFFFFF" andColorAlpha:1.0];
        cell.selectionStyle=UIAccessibilityTraitNone;
        if (indexPath.section==1) {
            cell.leftLable.text=@"微信公众号";
            cell.MyimageView.image=[UIImage imageNamed:@"weChat"];
            cell.MyimageView.frame=CGRectMake(cell.MyimageView.frame.origin.x, cell.imageView.frame.origin.y,17*XHSizeW, 14*XHSizeH);
            CGPoint center= cell.MyimageView.center;
            center.y=22.5*XHSizeH;
            cell.MyimageView.center=center;
        }else if(indexPath.section==2){
            if (indexPath.row==0){
                cell.leftLable.text=@"夸夸我";
                cell.MyimageView.image=[UIImage imageNamed:@"priseMe"];
                cell.MyimageView.frame=CGRectMake(cell.MyimageView.frame.origin.x, cell.imageView.frame.origin.y,17*XHSizeW, 20*XHSizeH);
                CGPoint center= cell.MyimageView.center;
                center.y=22.5*XHSizeH;
                cell.MyimageView.center=center;
            }else{
                cell.leftLable.text=@"关于字签";
                cell.MyimageView.image=[UIImage imageNamed:@"aboutWord"];
                cell.MyimageView.frame=CGRectMake(cell.MyimageView.frame.origin.x, cell.imageView.frame.origin.y,12*XHSizeW, 24*XHSizeH);
                CGPoint center= cell.MyimageView.center;
                center.y=22.5*XHSizeH;
                cell.MyimageView.center=center;
            }
        }
         return cell;
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
