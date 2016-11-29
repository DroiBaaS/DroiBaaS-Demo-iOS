//
//  HomeCommentViewController.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/7.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "HomeCommentViewController.h"
#import "HomeCommentCell.h"
#import "CommentModel.h"
#import "HUD.h"
@interface HomeCommentViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataSource;

@property (nonatomic , strong) News *news;

@property (nonatomic , strong) MyUser *user;

@end

@implementation HomeCommentViewController


- (instancetype)initWithUser:(MyUser *)user{
    if (self = [super init]) {
        _user = user;
    }
    return self;
}

- (instancetype)initWithNews:(News *)news{

    if (self = [super init]) {
        _news = news;
    }
    return self;
}

  
-(NSArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCommentCell" bundle:nil ] forCellReuseIdentifier:@"HomeCommentCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.tableFooterView = [UIView new];
    DroiCondition *cond = nil;
    if (_user) {
        cond = [DroiCondition cond:@"author._Id" andType:DroiCondition_EQ andArg2:_user.objectId];
    }
    if (_news) {
        cond = [DroiCondition cond:@"newsId" andType:DroiCondition_EQ andArg2:_news.objectId];

    }
    [self requestCommentDataByCond:cond];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//请求评论数据
- (void)requestCommentDataByCond:(DroiCondition *)cond{
    
    DroiQuery* query = [[[DroiQuery create] queryByClass:CommentModel.class] whereStatement:cond];
    // 开始查询并回调查询结果
    [HUD show];
    [query runQueryInBackground:^(NSArray *result, DroiError *err) {
        if (err.isOk) {
            // 成功！
            [self.dataSource addObjectsFromArray:result];
            [self.tableView reloadData];
            if ([self.dataSource count] == 0) {
                [HUD showText:@"没有评论"];
            }
            
        }
        else{
            [HUD showText:@"获取评论失败"];
        }
        
        [HUD dismiss];
    }];
}


#pragma mark dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCommentCell" forIndexPath:indexPath];
    CommentModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    return view;
}
@end
