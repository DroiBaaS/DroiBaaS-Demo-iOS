//
//  HomeViewController.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/4.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HomeCell1.h"
#import "MyUser.h"
#import "HomeDetailViewController.h"
#import "CommentModel.h"
#import <MJRefresh.h>
@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *dataSource;


@end

@implementation HomeViewController

-(NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        _dataSource =[[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"新闻";
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell1" bundle:nil] forCellReuseIdentifier:@"HomeCell1"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150.0;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    [ self.tableView.mj_header beginRefreshing];
    
}


- (void)requestNewData{
    
    DroiQuery *query = [[[DroiQuery create] queryByClass:[News class]] limit:20];
    [query runQueryInBackground:^(NSArray *result, DroiError *err) {
        if (err.isOk) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:result];
            [self.tableView reloadData];
            [self.tableView.mj_footer resetNoMoreData];
        }
        else{
            
        }
        [self.tableView.mj_header endRefreshing];
    }];
}


- (void)requestMoreData{
    
    NSInteger count = [self.dataSource count];
    DroiQuery *query = [[[[DroiQuery create] queryByClass:[News class]] limit:20] offset:(int)count];
    [query runQueryInBackground:^(NSArray *result, DroiError *err) {
        if (err.isOk) {
            if ([result count]) {
                if ([result count] < 20) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                [self.dataSource addObjectsFromArray:result];
                [self.tableView reloadData];
                [self.tableView.mj_footer endRefreshing];

            }
            else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        else{
            [self.tableView.mj_footer endRefreshing];
        }
        
    }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    //控制上拉加载的显示
    self.tableView.mj_footer.hidden = (self.dataSource.count == 0);
    return [self.dataSource count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell1" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeDetailViewController *detailVC = [[HomeDetailViewController alloc] init];
    detailVC.newsModel = self.dataSource[indexPath.row];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

@end
