//
//  AboutMeViewController.m
//  word
//
//  Created by 信和财富 on 2018/1/25.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*myTableView;
@property(nonatomic,strong)UIImageView*myImageView;

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"关于字签";
    self.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem*leftButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftBack"] style:0 target:self action:@selector(leftBack:)];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    self.view.backgroundColor=[UIColor colorWithHex:@"#F5F5F5" andColorAlpha:1.0f];
    self.navigationItem.leftBarButtonItem.tintColor=mainColor;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.myTableView];
}
-(void)leftBack:(UIBarButtonItem*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.myImageView.image.size.height*XHSizeH;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    [cell.contentView addSubview:self.myImageView];
    return cell;
}
-(UIImageView *)myImageView{
    if (!_myImageView) {
        _myImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aboutMe"]];
        _myImageView.frame=CGRectMake(0, 0, _myImageView.image.size.width*XHSizeW, _myImageView.image.size.height*XHSizeH);
    }
    return _myImageView;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _myTableView.backgroundColor=[UIColor lightGrayColor];
        _myTableView.dataSource=self;
        _myTableView.delegate=self;
    }
    return _myTableView;
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
