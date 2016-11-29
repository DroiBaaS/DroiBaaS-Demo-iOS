//
//  UserCollectionViewController.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/18.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "UserCollectionViewController.h"
#import <DroiCoreSDK/DroiCoreSDK.h>
#import <MJRefresh/MJRefresh.h>
#import "News.h"
#import "HomeCell1.h"
#import "HomeDetailViewController.h"
#import "HUD.h"
#import "MyUser.h"
#import "NewsRelation.h"
@interface UserCollectionViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataSource;

@end

@implementation UserCollectionViewController


-(NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        _dataSource =[[NSMutableArray alloc] init];
    }
    return _dataSource;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的收藏";
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell1" bundle:nil] forCellReuseIdentifier:@"HomeCell1"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    [self requestNewData];
}


- (void)requestNewData{
    
    MyUser *user = [MyUser getCurrentUserByUserClass:[MyUser class]];
    DroiCondition *cond = [DroiCondition cond:@"colletUserId" andType:DroiCondition_IN andArg2:user.UserId];
    DroiQuery *query = [[[[DroiQuery create] queryByClass:[NewsRelation class]]whereStatement:cond] limit:20];
    [query runQueryInBackground:^(NSArray *result, DroiError *err) {
        if (err.isOk) {
            if (result.count == 0) {
                [HUD showText:@"没有收藏!"];
            }
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:result];
            [self.tableView reloadData];
        }
        else{
            [HUD showText: [NSString stringWithFormat:@"发生错误%@",err.message]];
        }
        [self.tableView.mj_header endRefreshing];
        [HUD dismiss];
    }];
}


- (void)requestMoreData{
    
    MyUser *user = [MyUser getCurrentUserByUserClass:[MyUser class]];
    NSInteger count = [self.dataSource count];
    DroiCondition *cond = [DroiCondition cond:@"colletUserId" andType:DroiCondition_IN andArg2:user.UserId];
    DroiQuery *query = [[[[[DroiQuery create] queryByClass:[NewsRelation class]]whereStatement:cond] limit:20] offset:(int)count];
    [query runQueryInBackground:^(NSArray *result, DroiError *err) {
        
        if (err.isOk) {
            if ([result count]) {
                [self.dataSource addObjectsFromArray:result];
                [self.tableView reloadData];
            }
        }
        [self.tableView.mj_footer endRefreshing];
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //控制上拉加载的显示
    self.tableView.mj_footer.hidden = (self.dataSource.count % 20 != 0)||(self.dataSource.count == 0);
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell1" forIndexPath:indexPath];
    NewsRelation *relation = self.dataSource[indexPath.row];
    cell.model = relation.news;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeDetailViewController *detailVC = [[HomeDetailViewController alloc] init];
    NewsRelation *relation = self.dataSource[indexPath.row];
    detailVC.newsModel = relation.news;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}
@end
