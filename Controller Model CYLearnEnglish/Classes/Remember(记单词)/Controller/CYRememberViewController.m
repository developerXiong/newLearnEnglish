//
//  CYRememberViewController.m
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/14.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYRememberViewController.h"
#import "Head.pch"
#import "CYDataTool.h"

@interface CYRememberViewController ()<UITextViewDelegate,UITextFieldDelegate>

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

        //原始的数组数据
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
    
    // 如果是修改
    if ([self.where length]) {
        self.wordName.text = self.word;
        self.descriptions.text = self.describe;
    }
    
    self.wordName.delegate = self;
}

#pragma mark - textField设置

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.wordName becomeFirstResponder];
}

#pragma mark - 设置导航条
-(void)setUpNavigationBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:0 target:self action:@selector(clickSave)];
}

-(void)clickSave
{
    // 如果是修改
    if ([self.where length]) {
        
        for (int i = 0; i < self.dataArr.count; i++) {
            
            NSDictionary *dict = self.dataArr[i];
            
            if ([dict[@"describe"] isEqualToString:self.describe]&&[dict[@"word"] isEqualToString:self.word]) {
                
                [self.dataArr removeObject:dict];
                
            }
            
        }
        
    }
    
    if ([self.wordName.text length]||[self.descriptions.text length]) {
        //将输入的数据存为字典
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        if ([self.wordName.text length]) dataDict[@"word"] = self.wordName.text;
        if ([self.descriptions.text length]) dataDict[@"describe"] = self.descriptions.text;
        
        if ([self.wordName.text length] && ![self.descriptions.text length]) {
            dataDict[@"describe"] = @"请输入释义";
        }
        
        //将输入的数据保存
        [self.dataArr addObject:dataDict];
        
        //保存数据到plist
        [CYDataTool saveDataWithArr:self.dataArr];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeView" object:nil];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置textView
-(void)setUpTextView
{
    if ([self.describe length]) {
        self.textViewPlaceHolder.hidden = YES;
    }
    self.descriptions.layer.cornerRadius = 5;
    self.descriptions.layer.borderWidth = 0.5;
    self.descriptions.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor];
    self.descriptions.delegate = self;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.textViewPlaceHolder.hidden = YES;

}

-(void)textViewDidEndEditing:(UITextView *)textView
{

    if (![textView.text length]) {
        self.textViewPlaceHolder.hidden = NO;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
