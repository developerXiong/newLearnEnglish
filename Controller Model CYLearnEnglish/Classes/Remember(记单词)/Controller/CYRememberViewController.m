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

        NSMutableArray *oldArr = [CYDataTool oldDataArr];

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
    
    self.wordName.delegate = self;
}

#pragma mark - textField设置
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
//    CYLog(@"%@----%lu",string,(unsigned long)range.location);
    
    //如果输入的不是英文字母
    if (![self isEnglishLetter:string] && range.location==0) {
        
//        [CYOtherTools addAlertViewInVC:self message:@"请输入英文字母!"];
        [CYOtherTools addMBProgressWithView:self.view style:1];
        [CYOtherTools showMBWithTitle:@"请输入英文字母!"];
        [CYOtherTools hiddenMBDurtion:0.5];
        
        return NO;
        
    }
    
    return YES;
}

//判断是否是英文字母
-(BOOL)isEnglishLetter:(NSString *)str
{
    NSArray *bigArr = [CYDataTool getBigLetter];
    NSArray *smlArr = [CYDataTool getSmlLetter];
    
    for (int i = 0; i < 26; i++) {
        
        if ([str isEqualToString:bigArr[i]]||[str isEqualToString:smlArr[i]]) {
            return YES;
        }
        
    }
    
    return NO;
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
    
    //将输入的数据保存
    [self.dataArr addObject:dataDict];
    
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
