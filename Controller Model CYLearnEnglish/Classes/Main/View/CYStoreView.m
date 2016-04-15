//
//  CYStoreView.m
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/15.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYStoreView.h"

#import "Head.pch"

@interface CYStoreView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CYStoreView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpChildViews];
        
        self.backgroundColor = RGBColor(235, 234, 241, 1);
        
    }
    return self;
}

-(void)setUpChildViews
{
    UILabel *title = [[UILabel alloc] init];
    [self addSubview:title];
    _titleLabel = title;
    title.font = [UIFont systemFontOfSize:15];
    title.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    
    _titleLabel.text = title;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(20, 0, Width-20, 30);
    
}


@end
