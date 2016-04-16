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

/**
 *  tableView添加头视图的时候 设置style为plain 头视图会停留在 顶部固定住
 */

@interface CYMainViewController ()<UITableViewDataSource,UITableViewDelegate,CYMainCellDelegate>

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

#pragma mark - cell delegate
-(void)setUpCell
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 120, Width, 200)];
        [btn setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:btn];
        
    });
    
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
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
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
    
    cell.delegate = self;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [CYMainCell originalCell];
    
    CYLog(@"click cell");
}


-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *btnArr = [NSMutableArray array];
    
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:0 title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        CYLog(@"click delete%lu---%lu",indexPath.row,indexPath.section);
        
        /**
         *  深拷贝：将原来的数组完全拷贝，，拷贝的东西已经不是原来的东西，不能通过拷贝的来修改
            原来的。。。
            浅拷贝：只拷贝了原来数组的地址，修改的还是原来的数组
         */
        NSMutableArray *arr = self.dataArr[indexPath.section];
        
//        if (arr.count==1) {
//            [self.dataArr removeObject:arr];
//        }else{
            [arr removeObjectAtIndex:indexPath.row];
//        }

//        CYLog(@"%@",self.dataArr);
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:0];

        
    }];
    
    
    [btnArr addObject:action1];
    
    return btnArr;
    
}

//对编辑的状态下提交的事件响应
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [dataArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        CYLog(@"click delete");
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *arr = self.dataArr[section];
    
    CYStoreView *storeView = [[CYStoreView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
    
    CYLog(@"%lu====",(unsigned long)[arr count]);
    if (arr!=nil) {
        
        _storeView = storeView;
        storeView.title = arr[0][@"where"];
        return storeView;
        
    }
    
    return nil;
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
