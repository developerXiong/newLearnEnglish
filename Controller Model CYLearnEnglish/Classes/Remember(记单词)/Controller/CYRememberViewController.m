//
//  CYRememberViewController.m
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/14.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYRememberViewController.h"
#import "Head.pch"


@interface CYRememberViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *wordName;
@property (weak, nonatomic) IBOutlet UILabel *textViewPlaceHolder;
@property (weak, nonatomic) IBOutlet UITextView *descriptions;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation CYRememberViewController

-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
        
        NSMutableArray *oldArr = [CYDataTool dataArr];
        if (oldArr.count) {
            for (NSDictionary *dict in oldArr) {
                [_dataArr addObject:dict];
            }
        }
       
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"记单词";
    
    [self setUpTextView];
    [self setUpNavigationBar];
}

#pragma mark - 设置导航条
-(void)setUpNavigationBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:0 target:self action:@selector(clickSave)];
}

-(void)clickSave
{
    CYLog(@"点击完成");
    
    //将输入的数据存为字典
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    if ([self.wordName.text length]) dataDict[@"word"] = self.wordName.text;
    if ([self.descriptions.text length]) dataDict[@"describe"] = self.descriptions.text;
    
    //将输入的数据保存到最前面
    [self.dataArr insertObject:dataDict atIndex:0];
    //保存数据到plist
    [CYDataTool saveDataWithArr:self.dataArr];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置textView
-(void)setUpTextView
{
    self.descriptions.layer.cornerRadius = 5;
    self.descriptions.layer.borderWidth = 0.5;
    self.descriptions.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor];
    self.descriptions.delegate = self;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.textViewPlaceHolder.hidden = YES;
    CYLog(@"%s",__func__);
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    CYLog(@"%s",__func__);
    if (![textView.text length]) {
        self.textViewPlaceHolder.hidden = NO;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
