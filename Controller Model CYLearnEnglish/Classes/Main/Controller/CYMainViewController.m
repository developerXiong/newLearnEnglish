//
//  CYMainViewController.m
//  Controller Model CYLearnEnglish
//
//  Created by jeader on 16/4/14.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYMainViewController.h"

#import "CYMainCell.h"

#import "CYRememberViewController.h"

#import "Head.pch"

#import "CYDataTool.h"

#import "CYData.h"


@interface CYMainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *letterArr;

// 数据数组
@property (nonatomic, strong) NSMutableArray *dataArr;

/**
 *  数据模型数组
 */
@property (nonatomic, strong) NSMutableArray *dataModelArr;

@end

@implementation CYMainViewController

-(NSMutableArray *)dataModelArr
{
    if (_dataModelArr == nil) {
        _dataModelArr = [NSMutableArray array];
    }
    return _dataModelArr;
}

-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
        
        _dataArr = [CYDataTool dataArr];
        
        for (NSDictionary *dict in _dataArr) {
            
            CYData *data = [CYData dataWithDict:dict];
            
            [self.dataModelArr addObject:data];
        }
        
    }
    return _dataArr;
}

// 添加26个字母
-(NSMutableArray *)letterArr
{
    if (_letterArr == nil) {
        
        _letterArr = [NSMutableArray array];
        
        for (char i = 'a'; i <= 'z'; i++) {
            
            NSString *str = [NSString stringWithFormat:@"%c",i];
            
            [_letterArr addObject:str];
            
        }
      
    }
    return _letterArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self setUpNavigationBar];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
    CYLog(@"data----->%@",self.dataArr);
}

#pragma mark - 设置导航条
-(void)setUpNavigationBar
{
    self.title = @"Learn English";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"记单词" style:0 target:self action:@selector(clickRemember)];
}

-(void)clickRemember
{
    CYRememberViewController *remVC = [[CYRememberViewController alloc] init];
    
    [self.navigationController pushViewController:remVC animated:YES];
}

#pragma mark - tableView delegate datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 26;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"learnCell";
    CYMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CYMainCell" owner:nil options:nil][0];
        cell.selectionStyle = 0;
        
    }
    
    cell.letterName.text = @"asdasdasas";
    cell.letterMean.text = @"aiowjfp;aiowjioejfp;aofijp;asijfp;aosidjfaops;ifjop;asdijfpaos;iasfiojaiosfjsiafsa";
    
    CYData *data = self.dataModelArr[0];
    
    CYLog(@"word----%@",data.word);
    
    return cell;
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.letterArr[section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

@end
