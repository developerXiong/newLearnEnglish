//
//  CYOtherTools.m
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/15.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYOtherTools.h"

#import "MBProgressHUD.h"


static MBProgressHUD *_mbV;

@implementation CYOtherTools

+(void)addAlertViewInVC:(UIViewController *)viewController message:(NSString *)message
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:1];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    [alertVc addAction:action1];
    
    [viewController presentViewController:alertVc animated:YES completion:^{
        
    }];
    
}

/**
 *  添加MBProgress
 *
 *  @param view 添加到哪个视图上
 *  @param index MB展现的方式，0代表添加刷新视图，1代表不添加刷新只显示文字
 */
+(void)addMBProgressWithView:(UIView *)view style:(int)index
{
    _mbV = [[MBProgressHUD alloc] initWithView:view];
    
    if (index == 0) {
        
        _mbV.mode = MBProgressHUDModeIndeterminate;
        
    }else{
        
        _mbV.mode = MBProgressHUDModeCustomView;
        
    }
    /**
     *  自定义view
     */
    //    _mbV.customView
    
//    _mbV.color = [UIColor whiteColor];
    [view addSubview:_mbV];
    
    _mbV.activityIndicatorColor = [UIColor blackColor];
    
}

+(void)showMBWithTitle:(NSString *)title
{
    _mbV.labelText = title;
//    _mbV.labelColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [_mbV show:YES];
}

+(void)hiddenMBDurtion:(CGFloat)delay
{
    [_mbV hide:YES afterDelay:delay];
}


@end
