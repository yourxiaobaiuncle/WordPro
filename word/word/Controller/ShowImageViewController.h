//
//  ShowImageViewController.h
//  word
//
//  Created by 信和财富 on 2018/1/30.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XWPresentedOneControllerDelegate <NSObject>

- (void)presentedOneControllerPressedDissmiss;
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;

@end
@interface ShowImageViewController : UIViewController
@property (nonatomic, assign) id<XWPresentedOneControllerDelegate> delegate;
@property(nonatomic,strong)UIImage *image;
@end
