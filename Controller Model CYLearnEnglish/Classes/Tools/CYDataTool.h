//
//  CYDataTool.h
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/14.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYDataTool : NSObject

+(void)saveDataWithArr:(NSMutableArray *)dataArr;

+(NSMutableArray *)dataArr;

+(NSMutableArray *)oldDataArr;

//获取大写字母数组
+(NSArray *)getBigLetter;

//获取小写字母数组
+(NSArray *)getSmlLetter;



@end
