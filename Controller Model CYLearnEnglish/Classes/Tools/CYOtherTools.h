//
//  CYOtherTools.h
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/15.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface CYOtherTools : NSObject

+(void)addAlertViewInVC:(UIViewController *)viewController message:(NSString *)message;

/**
 *  添加MBProgress
 *
 *  @param view 添加到哪个视图上
 */
+ (void)addMBProgressWithView:(UIView *)view style:(int)index;
+ (void)showMBWithTitle:(NSString *)title;
+ (void)hiddenMBDurtion:(CGFloat)delay;

@end
