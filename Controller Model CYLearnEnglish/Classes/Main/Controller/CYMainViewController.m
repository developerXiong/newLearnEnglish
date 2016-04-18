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

#import "CYNoDataView.h"

/**
 *  tableView添加头视图的时候 设置style为plain 头视图会停留在 顶部固定住
 */

@interface CYMainViewController ()<UITableViewDataSource,UITableViewDelegate,CYMainCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *letterArr;

// 数据数组
@property (nonatomic, strong) NSMutableArray *dataArr;

//浮动视图
@property (nonatomic, strong) CYStoreView *storeView;

@property (nonatomic, strong) CYNoDataView *backview;

/**
 *  view的背景图片
 */
@property (nonatomic, strong) UIImageView *backgroundView;

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

        _letterArr = [CYDataTool getSmlLetter];
      
    }
    return _letterArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];
    
    if (!self.dataArr.count) {
        [self changeView];
    }
    
//        self.tableView.layer.zPosition = 1;
    
    [self setUpBackgroundImage];

}

#pragma mark - view的背景
-(void)setUpBackgroundImage
{
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundView.image = [UIImage imageNamed:@"backgroundImage"];
//    [self.view addSubview:backgroundView];
    self.tableView.backgroundView = backgroundView;
    
}

// 改变tableview背景
-(void)changeView
{
    //随机数
    int i = arc4random() % 10; //随机生成[0，10）包括0不包括10
    
    NSString *imageName1 = [NSString stringWithFormat:@"image%d",i];
    
    self.tableView.hidden = YES;
    CYNoDataView *view = [CYNoDataView shareNodataView];
    view.imageName = imageName1;
    [view show];
    _backview = view;
    
    [self.view addSubview:view];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getAndReloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeView) name:@"changeView" object:nil];
    
}

#pragma mark - 添加索引
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return nil;
//    }
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSArray *dataArr in self.dataArr) {
        
        NSString *str = dataArr[0][@"where"];
        
        [arr addObject:str];
        
    }
    
    return arr;
}

#pragma mark - 获取并刷新数据
-(void)getAndReloadData
{
    
    if ([CYDataTool dataArr].count) {
    
        [self.dataArr removeAllObjects];
        [self.backview hidden];
        
        self.tableView.estimatedRowHeight = 100;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        // 设置索引的颜色
        self.tableView.sectionIndexColor = [UIColor blueColor];
        
        // 索引背景色
        self.tableView.sectionIndexBackgroundColor = RGBColor(254, 233, 232, 1);
        // 索引点击的颜色
//        self.tableView.sectionIndexTrackingBackgroundColor = [UIColor greenColor];
        
        self.tableView.hidden = NO;
        self.dataArr = [CYDataTool dataArr];
        self.dataArr = [CYDataTool dealwithArr:self.dataArr];
        
        [self.tableView reloadData];
        
    }else{
        
        [self changeView];
        
    }
}

#pragma mark - 设置导航条
-(void)setUpNavigationBar
{
//    self.title = @"Learn English";
    // 左边的导航栏item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"记单词" style:0 target:self action:@selector(clickRemember)];
    // 右边的导航栏item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:0 target:self action:@selector(clear)];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"backgroundImage"] forBarMetrics:0];
    
    self.navigationItem.title = @"Learn English";
    
//    设置导航栏下方不显示内容，此时导航栏无透明度
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.navigationController.navigationBar.translucent = YES;
    
}

-(void)clickRemember
{
    CYRememberViewController *remVC = [[CYRememberViewController alloc] init];
    
    [self.navigationController pushViewController:remVC animated:YES];
}

//点击左边的item
-(void)clear
{
    [CYOtherTools addAlertViewInVC:self message:@"确定清空所有?" doWhat:^{
       
        if (self.dataArr.count) {
            
            [self.dataArr removeAllObjects];
            [self.tableView reloadData];
            [CYDataTool saveDataWithArr:self.dataArr];
            [self getAndReloadData];
            
        }else{
            
            [CYOtherTools addMBProgressWithView:self.view style:1];
            [CYOtherTools showMBWithTitle:@"已经啥都没有了，留点活路吧!"];
            [CYOtherTools hiddenMBDurtion:1];
            
        }
        
    }];
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

    CYMainCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
    cell = [[NSBundle mainBundle]loadNibNamed:@"CYMainCell" owner:nil options:nil][0];
    cell.selectionStyle = 0;
    
    cell.letterName.text = self.dataArr[indexPath.section][indexPath.row][@"word"];
    NSString *means = [NSString stringWithFormat:@"释义：%@",self.dataArr[indexPath.section][indexPath.row][@"describe"]];
    cell.letterMean.text = means;
    
    cell.delegate = self;

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CYLog(@"click cell");
}


-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *btnArr = [NSMutableArray array];
    
    // 删除按钮
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:0 title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        /**
         *  深拷贝：将原来的数组完全拷贝，，拷贝的东西已经不是原来的东西，不能通过拷贝的来修改
            原来的。。。
            浅拷贝：只拷贝了原来数组的地址，修改的还是原来的数组
         */
        NSMutableArray *arr = self.dataArr[indexPath.section];
        
        if (arr.count==1) {
            [self.dataArr removeObject:arr];
            // 删除指定组
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            if (!self.dataArr.count) {
            
                // 通知主界面刷新
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeView" object:nil];
                
            }
            
        }else{
            [arr removeObjectAtIndex:indexPath.row];
            // 删除指定的单元格
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:0];
        }
        
        // 将处理过的数组还原成原始数组
        NSMutableArray *tempArr = [NSMutableArray array];
        
        for (int i = 0; i < self.dataArr.count; i++) {
            
            for (NSDictionary *dict in self.dataArr[i]) {
                
                [tempArr addObject:dict];
                
            }
            
        }
        // 将数组保存到plist
        [CYDataTool saveDataWithArr:tempArr];
        if (!self.dataArr.count) {
            
            [tableView reloadData];
        }
        
        
    }];
    
    // 修改
    UITableViewRowAction *addAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
//        CYLog(@"%@",action);
        
        
        
    }];
    

    [btnArr addObject:action1];
    [btnArr addObject:addAction];

    return btnArr;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.dataArr.count) {
        
        NSArray *arr = self.dataArr[section];
        
        CYStoreView *storeView = [[CYStoreView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
        
        if (arr!=nil) {
            
            _storeView = storeView;
            storeView.title = arr[0][@"where"];
            return storeView;
            
        }
        
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

#pragma mark - tableView 滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offY = scrollView.contentOffset.y;
    
//    CYLog(@"%f",offY);
    
    if (offY>-64) {
        
//        [self.navigationController.navigationBar setBackgroundColor:[UIColor orangeColor]];
        
    }

    
}

@end
