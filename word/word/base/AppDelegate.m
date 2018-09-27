//
//  AppDelegate.m
//  word
//
//  Created by Mac on 2017/12/25.
//  Copyright © 2017年 xinHeYanJunYuan. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LHQGudicView.h"
#import <UMShare/UMSocialManager.h>
#import <Photos/PHPhotoLibrary.h>
#import <Photos/PHAssetChangeRequest.h>
//#import <UMSocialCore/UMSocialCore.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMKey];
    [self configUSharePlatforms];
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"savePic"] isEqualToString:@"0"]&&![[[NSUserDefaults standardUserDefaults] valueForKey:@"savePic"] isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"savePic"];
    }
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"savePicToPhotoAlbum"] isEqualToString:@"0"]&&![[[NSUserDefaults standardUserDefaults] valueForKey:@"savePicToPhotoAlbum"] isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"savePicToPhotoAlbum"];
    }
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{

    } completionHandler:^(BOOL success, NSError * _Nullable error) {
    }];
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController=[[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init] ];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [LHQGudicView sharedWithImages:@[@"wen1.png",@"sheng1.png",@"yong1.png"]];
    return YES;
}
- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:weChatKey appSecret:weChatSecret redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:weChatKey appSecret:weChatSecret redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
   // [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQKey/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
    //[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:sinaKey  appSecret:sinaSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
