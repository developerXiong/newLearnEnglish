//
//  CYNoDataView.m
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/16.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYNoDataView.h"

#import "Head.pch"

@interface CYNoDataView ()

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *midLabel;

@property (nonatomic, strong) UILabel *botLabel;

@end

@implementation CYNoDataView

+(instancetype)shareNodataView
{
    static CYNoDataView *_noview;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        _noview = [[self alloc] initWithFrame:CGRectMake(0, 64, Width, Height-64)];
        
    });
    
    return _noview;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpChildViews];
        
    }
    return self;
}

-(void)setUpChildViews
{
    UIImageView *imageV = [[UIImageView alloc] init];
    _imageV = imageV;
    [self addSubview:imageV];
    imageV.contentMode = UIViewContentModeRedraw;
    
    UILabel *topLabel = [[UILabel alloc] init];
    _topLabel = topLabel;
    [self addSubview:topLabel];
    topLabel.text = @"你的单词库空空如也!";
    topLabel.textColor = RGBColor(250, 202, 14, 1);
//    topLabel.textAlignment = NSTextAlignmentCenter;
    
    _midLabel = [[UILabel alloc] init];
    _midLabel.text = @"快去添加你想学习的单词吧！";
    _midLabel.textColor = RGBColor(250, 202, 14, 1);
//    _midLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_midLabel];
    
}

-(void)setImageName:(NSString *)imageName
{
    imageName = imageName;
    _imageV.image = [UIImage imageNamed:imageName];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageV.frame = self.bounds;
    _topLabel.frame = CGRectMake(20, 25, Width-20, 25);
    _midLabel.frame = CGRectMake(20, CGRectGetMaxY(_topLabel.frame)+25, Width-20, 25);
}

-(void)show
{
    self.hidden = NO;
}

-(void)hidden
{
    self.hidden = YES;
}

@end
