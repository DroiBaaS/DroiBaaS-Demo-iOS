//
//  HomeDetailViewController.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/7.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "HomeCommentViewController.h"
#import "CommentModel.h"
#import "NewsRelation.h"
#import "DroiLog.h"
#import "HUD.h"
#import "UserLoginViewController.h"
@interface HomeDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *commentTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLead;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (nonatomic , strong) NewsRelation *relation;

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self setupNavigationBar];
   NSString *htmlStr = [NSString stringWithFormat:@"<head> </head> <article class=\"typo container\"><div id=\"body\" class=\"fontsizetwo\"><h1 class=\"heading\" id=\"gsTemplateContent_Title\">%@</h2><span class=\"info\" id=\"gsTemplateContent_Subtitle\">作者: %@ </span><hr></hr>%@",self.newsModel.newsDescription,self.newsModel.authorName,self.newsModel.htmlString];
    NSString *str = [self importStyleWithHtmlString:htmlStr];
    [self.webView loadHTMLString:str baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    self.collectBtn.selected = [self isCollected];
    
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark WebDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

- (void)setupNavigationBar{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"评论" style:UIBarButtonItemStyleDone target:self action:@selector(toComment)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (IBAction)collectNews:(UIButton *)sender {
    if (sender.isSelected) {
        
        [self cancelCollect];
    }
    else{
        [self collectNews];
    }
    
}

- (void)toComment{
    
    HomeCommentViewController *commentVC = [[HomeCommentViewController alloc] initWithNews:self.newsModel];
    [self.navigationController pushViewController:commentVC animated:YES];
    
}

//是否已收藏
- (BOOL)isCollected{
    
    MyUser *user = [MyUser getCurrentUserByUserClass:[MyUser class]];
    //如果是匿名用户的话 设置为nil
    if (user.isAnonymous) {
        return NO;
    }
    
    NSString *newsObjId = self.newsModel.objectId;
    DroiQuery *query = [[DroiQuery create] queryByClass:[NewsRelation class]];
    DroiCondition *cond1 = [DroiCondition cond:@"newsId" andType:DroiCondition_EQ andArg2:newsObjId];
    DroiCondition *cond2 = [DroiCondition cond:@"colletUserId" andType:DroiCondition_EQ andArg2:user.UserId];
    query = [query whereStatement:[cond1 and:cond2]];
    
    DroiError *error = nil;
    NSArray *array = [query runQuery:&error];
    if (error.isOk && ([array count] >= 1)) {
        self.relation = array[0];
        return YES;
    }
    return NO;
}

//收藏
- (void)collectNews{
   
    MyUser *user = [MyUser getCurrentUserByUserClass:[MyUser class]];
    //如果是匿名用户的话 跳转到登陆页面
    if (user.isAnonymous) {
        
        UserLoginViewController *loginVC = [[UserLoginViewController alloc] initWithStyle:LoginStyle];
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }
    
    NSString *newsObjId = self.newsModel.objectId;
    NSString *collectUserId = user.UserId;
    NewsRelation *relation = [[NewsRelation alloc] init];
    relation.newsId = newsObjId;
    relation.colletUserId = collectUserId;
    relation.news = self.newsModel;
    relation.colletUser = user;
    [HUD show];
    [relation saveInBackground:^(BOOL result, DroiError *error) {
        if (error.isOk) {
            [HUD showText:@"收藏成功"];
            self.collectBtn.selected = YES;
        }
        else{
            [HUD showText:[NSString stringWithFormat:@"收藏失败%@",error.message]];
        }
        [HUD dismiss];
    }];
}

//取消收藏
- (void)cancelCollect{
    
    [HUD show];
    [self.relation deleteInBackground:^(BOOL result, DroiError *error) {
        if (error.isOk) {
            [HUD showText:@"取消收藏"];
            self.collectBtn.selected = NO;
        }
        else{
            [HUD showText:[NSString stringWithFormat:@"取消失败%@",error.message]];
        }
        [HUD dismiss];
    }];
}

//发表评论
- (IBAction)summitComment:(id)sender {
    
    if (self.commentTF.text == nil || [self.commentTF.text isEqualToString:@""]) {
        return;
    }
    DroiPermission* permission = [DroiPermission new];
    [permission setPublicReadPermission:YES];
//    [permission setPublicWritePermission:YES];
    CommentModel *comment = [[CommentModel alloc] init];
    MyUser *user = [MyUser getCurrentUserByUserClass:[MyUser class]];
    //如果是匿名用户的话 设置为nil
    if (user.isAnonymous) {
        user = nil;
    }
    comment.author = user;
    //存newsId用于查询评论
    comment.newsId = self.newsModel.objectId;
    comment.comment = self.commentTF.text;
    comment.permission = permission;
    
    [HUD show];
    [comment saveInBackground:^(BOOL result, DroiError *error) {
        if (error.isOk) {
            [HUD showText:@"发表成功"];
            self.commentTF.text =@"";
            [self.view endEditing:YES];
        }
        else{
            [HUD showText:[NSString stringWithFormat:@"发表失败%@",error.message]];
        }
        [HUD dismiss];
}];
    
}

- (NSString *)importStyleWithHtmlString:(NSString *)HTML
{
    //老的字符串通过HTML这个参数传递过来
    //先找到布局文件的路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"style" ofType:@"css"];
    //    NSLog(@"-%@",filePath);
    //替换HTML字符串中的布局， 修改为通过本地文件配置
    //1.先写一个可用于配置布局的字符串命令，并设置配置类型为本地的文件（命令都是HTML语言， 可以不用懂， 大致知道什么意思就可以了， 文件内容可以让webView中的图片适应屏幕宽度）
    NSString *replace = [NSString stringWithFormat:@"<link href=\"%@\" rel=\"stylesheet\" type=\"text/css\"/>",filePath];
    //2.替换原有的命令字符串
    HTML = [HTML stringByReplacingOccurrencesOfString:@"</head>" withString:replace];
    //返回新配置的HTML字符串
    return HTML;
}

#pragma mark Keyboard Notification
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.bottomLead.constant  = keyboardRect.size.height;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.bottomLead.constant  = 0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
@end
