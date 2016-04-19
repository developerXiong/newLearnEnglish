//
//  CYRememberViewController.h
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/14.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYRememberViewController : UIViewController

/**
 *  判断是否 为修改 ，还是新增
 */
@property (nonatomic, copy) NSString *where;
/**
 *  单词名字
 */
@property (nonatomic, copy) NSString *word;
/**
 *  描述
 */
@property (nonatomic, copy) NSString *describe;

@end
