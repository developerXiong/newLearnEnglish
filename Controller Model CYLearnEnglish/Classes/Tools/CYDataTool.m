//
//  CYDataTool.m
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/14.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYDataTool.h"
#import "Head.pch"

#define dataFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"data.plist"]

@implementation CYDataTool

+(void)saveDataWithArr:(NSMutableArray *)dataArr
{
    [dataArr writeToFile:dataFilePath atomically:NO];
}

+(NSMutableArray *)dataArr
{
    
    //取出plist数据
    NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:dataFilePath];
    
    
    return arr;
}

//处理原始的数据
+(NSMutableArray *)dealwithArr:(NSMutableArray *)arr
{
    //初始化section数组
    NSMutableArray *secArr = [NSMutableArray array];
    
    //初始化row数组
    //    NSMutableArray *rowArr = [NSMutableArray array];
    
    for (int i = 0; i < 26; i ++) {
        
        NSMutableArray *rowArr = [NSMutableArray array];
        
        [secArr addObject:rowArr];
        
    }
    
    //小写字母
    NSMutableArray *smlArr = [NSMutableArray array];
    for (int i = 'a'; i <= 'z'; i++) {
        
        [smlArr addObject:[NSString stringWithFormat:@"%c",i]];
        
    }
    
    //大写字母
    NSMutableArray *bigArr = [NSMutableArray array];
    for (int i = 'A'; i <= 'Z'; i++) {
        
        [bigArr addObject:[NSString stringWithFormat:@"%c",i]];
        
    }
    
    
    
    
    
    //遍历数据数组 取出字典
    for (NSDictionary *dict in arr) {
        
        NSString *str = [dict[@"word"] substringToIndex:1];
        
        //比较word与26个字母
        for (int i = 0; i < 26; i ++) {
            
            if ([str isEqual:smlArr[i]]||[str isEqual:bigArr[i]]) {
                
                NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
                dict1[@"word"] = dict[@"word"];
                dict1[@"describe"] = dict[@"describe"];
                dict1[@"where"] = bigArr[i];
                
                [secArr[i] addObject:dict1];
                
                
            }
            
        }
        
    }
    
    CYLog(@"second secArr---->%lu",(unsigned long)secArr.count);
    
    NSMutableArray *lastArr = [NSMutableArray array];
    
    for (int i = 0; i < 26; i++) {
        
        NSArray *arr = (NSArray *)secArr[i];
        
        if (![arr isEqualToArray:@[]]) {
            
            [lastArr addObject:arr];
        }
        
    }
    
    CYLog(@"lastArr---->%@",lastArr);
    
    return lastArr;
}

+(NSMutableArray *)getBigLetter
{
    NSMutableArray *bigArr = [NSMutableArray array];
    for (int i = 'A'; i <= 'Z'; i++) {
        
        [bigArr addObject:[NSString stringWithFormat:@"%c",i]];
        
    }
    
    return bigArr;
}

+(NSMutableArray *)getSmlLetter
{
    NSMutableArray *smlArr = [NSMutableArray array];
    for (int i = 'a'; i <= 'z'; i++) {
        
        [smlArr addObject:[NSString stringWithFormat:@"%c",i]];
        
    }
    return smlArr;
}


@end
