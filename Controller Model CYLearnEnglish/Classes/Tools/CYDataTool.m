//
//  CYDataTool.m
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/14.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYDataTool.h"

#define dataFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"data.plist"]

@implementation CYDataTool

+(void)saveDataWithArr:(NSMutableArray *)dataArr
{
    [dataArr writeToFile:dataFilePath atomically:NO];
}

+(NSMutableArray *)dataArr
{
    return [[NSMutableArray alloc] initWithContentsOfFile:dataFilePath];
}

@end
