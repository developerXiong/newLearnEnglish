//
//  CYDataTool.h
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/14.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYDataTool : NSObject

/**
 *  传入原始的数组数据并保存
 */
+(void)saveDataWithArr:(NSMutableArray *)dataArr;

/**
 *  返回原始的数据
 */
+(NSMutableArray *)dataArr;

/**
 *  将传入的数组数据处理 并返回
 */
+(NSMutableArray *)dealwithArr:(NSMutableArray *)arr;

/**
 *  获取大写字母数组
 */
+(NSMutableArray *)getBigLetter;

/**
 *  获取小写字母数组
 */
+(NSMutableArray *)getSmlLetter;



@end
