//
//  CYData.h
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/14.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYData : NSObject

@property (nonatomic, copy) NSString *word;

@property (nonatomic, copy) NSString *describe;

+(instancetype)dataWithDict:(NSDictionary *)dict;

@end
