//
//  InPutViewController.h
//  word
//
//  Created by Mac on 2018/1/5.
//  Copyright © 2018年 xinHeYanJunYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void (^returnNsstringBlock)(NSString*returnString,NSString*fonyFamily);

@interface InPutViewController : UIViewController
@property(nonatomic,copy)returnNsstringBlock stringBlock;
@property(nonatomic,copy)NSString*stringText;
@property(nonatomic,assign)NSInteger wordNum;
@property(nonatomic,copy)NSString*fontFimaly;
@end
