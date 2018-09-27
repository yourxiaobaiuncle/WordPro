//
//  LHQGudicView.m
//  手机贷
//
//  Created by hongqiangli on 17/3/20.
//  Copyright © 2017年 李洪强. All rights reserved.
//

#import "LHQGudicView.h"
static NSString *const kAppVersion = @"appVersion";

@interface LHQGudicView ()<UIScrollViewDelegate>
{
    UIScrollView  *launchScrollView;
    UIPageControl *page;
}

@end

@implementation LHQGudicView

NSArray *images;
BOOL isScrollOut;//在最后一页再次滑动是否隐藏引导页
CGRect enterBtnFrame;
NSString *enterBtnImage;
static LHQGudicView *launch = nil;
#pragma mark - 创建对象-->>不带button
+(instancetype)sharedWithImages:(NSArray *)imageNames{
    images = imageNames;
    isScrollOut = YES;
    launch = [[LHQGudicView alloc] initWithFrame:CGRectMake(0, 0, XHScreenW, XHScreenH)];
    launch.backgroundColor = [UIColor whiteColor];
    return launch;
}

#pragma mark - 创建对象-->>带button
+(instancetype)sharedWithImages:(NSArray *)imageNames buttonImage:(NSString *)buttonImageName buttonFrame:(CGRect)frame{
   
    images = imageNames;
    isScrollOut = NO;
    enterBtnFrame = frame;
    enterBtnImage = buttonImageName;
    launch = [[LHQGudicView alloc] initWithFrame:CGRectMake(0, 0, XHScreenW, XHScreenH)];
    launch.backgroundColor = [UIColor whiteColor];
    return launch;
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:@"currentColor" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"nomalColor" options:NSKeyValueObservingOptionNew context:nil];
        if ([self isFirstLauch]) {
            UIWindow *window = [[UIApplication sharedApplication] windows].lastObject;
            [window addSubview:self];
            [self addImages];
        }else{
            [self removeFromSuperview];
        }
    }
    return self;
}
#pragma mark - 判断是不是首次登录或者版本更新
-(BOOL )isFirstLauch{
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    //获取上次启动应用保存的appVersion
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:kAppVersion];
    //版本升级或首次登录
    if (version == nil || ![version isEqualToString:currentAppVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentAppVersion forKey:kAppVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
    //return YES;
}
#pragma mark - 添加引导页图片
-(void)addImages{
    [self createScrollView];
}
#pragma mark - 创建滚动视图
-(void)createScrollView{
    launchScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, XHScreenW, XHScreenH)];
    launchScrollView.showsHorizontalScrollIndicator = NO;
    launchScrollView.bounces = NO;
    launchScrollView.pagingEnabled = YES;
    launchScrollView.delegate = self;
    launchScrollView.contentSize = CGSizeMake(XHScreenW * images.count, XHScreenH);
    [self addSubview:launchScrollView];
    for (int i = 0; i < images.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * XHScreenW, 0, XHScreenW, XHScreenH)];
        imageView.image = [UIImage imageNamed:images[i]];
        if (i==0) {
            UIImageView *imageViewLitter=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Group"]];
            
            imageViewLitter.frame=CGRectMake(244*XHSizeW, 43*XHSizeH, 44*XHSizeW, 270*XHSizeH);
            [imageView addSubview:imageViewLitter];
            
            imageViewLitter.alpha=0;
            [UIView animateWithDuration:2 animations:^{
                imageViewLitter.alpha=1;
            }];
            imageViewLitter.tag=1000;
            imageView.tag=100;
        }else if (i==1){
            UIImageView *imageViewLitter=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sheng"]];
            imageViewLitter.frame=CGRectMake(50*XHSizeW, 361*XHSizeH, 44*XHSizeW, 270*XHSizeH);
            [imageView addSubview:imageViewLitter];
            imageViewLitter.tag=1001;
            imageView.tag=101;
            imageViewLitter.alpha=0;
        }else if (i==2){
            UIImageView *imageViewLitter=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yong"]];
            imageViewLitter.frame=CGRectMake(270*XHSizeW, 360*XHSizeH, 44*XHSizeW, 270*XHSizeH);
            [imageView addSubview:imageViewLitter];
            imageViewLitter.tag=1002;
            imageView.tag=102;
            imageViewLitter.alpha=0;
        }
        [launchScrollView addSubview:imageView];
        if (i == images.count - 1) {
            //判断要不要添加button
            if (!isScrollOut) {
                UIButton *enterButton = [[UIButton alloc] init];
                [enterButton setImage:[UIImage imageNamed:enterBtnImage] forState:UIControlStateNormal];
                [enterButton addTarget:self action:@selector(enterBtnClick) forControlEvents:UIControlEventTouchUpInside];
                [imageView addSubview:enterButton];
                imageView.userInteractionEnabled = YES;
//                [enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.centerX.equalTo(imageView);
//                    make.bottom.equalTo(imageView.mas_bottom).offset(-70*XHSizeH);
//                    make.width.equalTo(@(150 *XHSizeW));
//                    make.height.equalTo(@(60*XHSizeH));
//                }];
            }
        }
    }
        page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, XHScreenH - 50, XHScreenW, 30)];
        page.numberOfPages = images.count;
        //page.backgroundColor = [UIColor clearColor];
        page.currentPageIndicatorTintColor =[UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
    
  
        page.pageIndicatorTintColor=[UIColor colorWithHex:@"#EEC894" andColorAlpha:0.5];
    
    
        page.currentPage = 0;
        page.defersCurrentPageDisplay = YES;
        [self addSubview:page];
    
    
}
#pragma mark - 进入按钮
-(void)enterBtnClick{
    [self hideGuidView];
}
#pragma mark - 隐藏引导页
-(void)hideGuidView{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
        
    }];
}
#pragma mark - scrollView Delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    int cuttentIndex = (int)(scrollView.contentOffset.x + XHScreenW/2)/XHScreenW;
    if (cuttentIndex == images.count - 1) {
        if ([self isScrolltoLeft:scrollView]) {
            if (!isScrollOut) {
                return ;
            }
            [self hideGuidView];
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == launchScrollView) {
        int cuttentIndex = (int)(scrollView.contentOffset.x + XHScreenW/2)/XHScreenW;
        page.currentPage = cuttentIndex;
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger pageNum=scrollView.contentOffset.x/XHScreenW;
    UIImageView*imageView=[scrollView viewWithTag:100];
    UIImageView*imageViewLitter=[imageView viewWithTag:1000];
    UIImageView*imageView2=[scrollView viewWithTag:101];
    UIImageView*imageViewLitter2=[imageView2 viewWithTag:1001];
    UIImageView*imageView3=[scrollView viewWithTag:102];
    UIImageView*imageViewLitter3=[imageView3 viewWithTag:1002];
    imageViewLitter.alpha=0;
    imageViewLitter2.alpha=0;
    imageViewLitter3.alpha=0;
    
    if(pageNum==0){
        UIImageView*imageView=[scrollView viewWithTag:100];
        UIImageView*imageViewLitter=[imageView viewWithTag:1000];
        [UIView animateWithDuration:2 animations:^{
            imageViewLitter.alpha=1;
        }];
    }
    if (pageNum==1) {
        UIImageView*imageView=[scrollView viewWithTag:101];
        UIImageView*imageViewLitter=[imageView viewWithTag:1001];
        [UIView animateWithDuration:2 animations:^{
            imageViewLitter.alpha=1;
            
        }];
    }else if (pageNum==2){
        UIImageView*imageView=[scrollView viewWithTag:102];
        UIImageView*imageViewLitter=[imageView viewWithTag:1002];
        [UIView animateWithDuration:2 animations:^{
            imageViewLitter.alpha=1;
            
        }];
    }
    
}
#pragma mark - 判断滚动方向
-(BOOL )isScrolltoLeft:(UIScrollView *) scrollView{
    //返回YES为向左反动，NO为右滚动
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark - KVO监测值的变化
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"currentColor"]) {
        page.currentPageIndicatorTintColor = [UIColor colorWithHex:@"#EEC894" andColorAlpha:1.0];
    }
    if ([keyPath isEqualToString:@"nomalColor"]) {
        page.pageIndicatorTintColor = [UIColor colorWithRed:238 green:200 blue:148 alpha:0.5];
    }
}


@end
