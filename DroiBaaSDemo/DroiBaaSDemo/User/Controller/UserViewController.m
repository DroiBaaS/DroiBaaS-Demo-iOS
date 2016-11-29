//
//  UserViewController.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/4.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "UserViewController.h"
#import <DroiCoreSDK/DroiCoreSDK.h>
#import "MyUser.h"
#import "DroiLog.h"
#import "UserLoginViewController.h"
#import "HomeCommentViewController.h"
#import <UIImageView+WebCache.h>
#import "UserInfoViewController.h"
#import "UserCollectionViewController.h"
#import <DroiFeedback/DroiFeedback.h>
@interface UserViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;

@property (weak, nonatomic) IBOutlet UIButton *userIconButton;
@end

@implementation UserViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
    [self requestUserData];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}


- (void)requestUserData{
    
    MyUser *currentUser = [MyUser getCurrentUserByUserClass:[MyUser class]];
    //判断是否为匿名用户
    if (!currentUser.isAnonymous && currentUser.isAuthorized) {
        
        NSString *name = currentUser.UserId;
        if (currentUser.nickName) {
            name = currentUser.nickName;
        }
        self.userNameLabel.text = name;
        NSURL *iconURL = currentUser.icon.getUrl;
        [self.userIconImageView sd_setImageWithURL:iconURL placeholderImage:[UIImage imageNamed:@"Placeholder_Icon"]];
        
    }
        else {
            self.userNameLabel.text = @"未登录";
            [self.userIconImageView setImage:[UIImage imageNamed:@"Placeholder_Icon"]];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabelView.dataSource = self;
    self.tabelView.delegate = self;
    [self.tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UserCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tabelViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    NSString *string = nil;
    switch (indexPath.row) {
        case 0:
            string = @"个人资料";
            break;
        case 1:
            string = @"我的收藏";
            break;
        case 2:
            string = @"我的评论";
            break;
        case 3:
            string = @"意见反馈";
            break;
        default:
            break;
    }
    cell.textLabel.text = string;
    return cell;
}

#pragma mark tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
      MyUser *currentUser = [MyUser getCurrentUserByUserClass:[MyUser class]];
    
    
    if (!currentUser.isAnonymous && currentUser.isAuthorized) {
    
        switch (indexPath.row) {
            case 0:
                [self toUserInfoVC];
                break;
            case 1:
                [self toMyCollection];
                break;
            case 2:
                [self toMyComment];
                break;
            case 3:
                [self toFeedBack];
            default:
                break;
        }
    }
    
    else{
        
        UserLoginViewController *loginVC = [[UserLoginViewController alloc] initWithStyle:LoginStyle];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
}

#pragma private method

//点击个人信息
- (void)toUserInfoVC{
    
    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
    userInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoVC animated:YES];
}

- (void)toMyComment{
    
    MyUser *currentUser = [MyUser getCurrentUserByUserClass:[MyUser class]];
    HomeCommentViewController *commentVC = [[HomeCommentViewController alloc] initWithUser:currentUser];
    commentVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commentVC animated:YES];
    
}

- (void)toMyCollection{
    
    UserCollectionViewController *collectionVC = [[UserCollectionViewController alloc] init];
    collectionVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:collectionVC animated:YES];
    
}

//调用反馈页面
- (void)toFeedBack{
    
    [DroiFeedback callFeedbackWithViewController:self];
}
@end
