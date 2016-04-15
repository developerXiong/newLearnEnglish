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

#import "CYStoreView.h"

//#import "CYData.h"


@interface CYMainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *letterArr;

// 数据数组
@property (nonatomic, strong) NSMutableArray *dataArr;

//浮动视图
@property (nonatomic, strong)CYStoreView *storeView;

@end

@implementation CYMainViewController

-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    
        
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
    if ([CYDataTool dataArr]) {
        
        [self.dataArr removeAllObjects];
        
        self.dataArr = [CYDataTool dataArr];
        [self.tableView reloadData];
        
    }
    
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
//    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
//    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"learnCell";
    CYMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CYMainCell" owner:nil options:nil][0];
        cell.selectionStyle = 0;
        
    }
    
    
    cell.letterName.text = self.dataArr[indexPath.section][indexPath.row][@"word"];
    
    NSString *means = [NSString stringWithFormat:@"释义：%@",self.dataArr[indexPath.section][indexPath.row][@"describe"]];
    cell.letterMean.text = means;
    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CYStoreView *storeView = [[CYStoreView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
    _storeView = storeView;
    storeView.title = self.dataArr[section][0][@"where"];
    //    return self.dataArr[section][0][@"where"];
    return storeView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    CYLog(@"%s=========%lu====%@",__func__,section,view);
}

#pragma mark - tableview滚动的时候调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollY = scrollView.contentOffset.y;
//    CYLog(@"%f",scrollY);
}

#pragma mark - 添加浮动视图
-(void)addStoreView
{
    
}

@end
