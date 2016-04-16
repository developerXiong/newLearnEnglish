//
//  CYNoDataView.h
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/16.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYNoDataView : UIView

@property (nonatomic, copy) NSString *imageName;

+(instancetype)shareNodataView;

-(void)show;

-(void)hidden;

@end
