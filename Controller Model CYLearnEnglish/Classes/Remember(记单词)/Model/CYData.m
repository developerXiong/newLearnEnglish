//
//  CYData.m
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/14.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYData.h"

@implementation CYData

+(instancetype)dataWithDict:(NSDictionary *)dict
{
    CYData *data = [[self alloc] init];
    
    [data setValuesForKeysWithDictionary:dict];
    
    return data;
}

@end
