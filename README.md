# DroiBaaSDemo-iOS
本项目展示的是 DroiBaaS 相关功能

## 业务需求
### 一、用户系统
1. 建立用户系统
2. 提供注册/登录功能
3. 修改密码
4. 的上传头像/显示头像
5. 查看收藏与评论

### 二、首页新闻信息list展示
展示新闻的标题和缩略图

### 三、新闻详情展示
展示新闻的详细信息

### 四、新闻的收藏与评论功能
在用户登录的情况下可以对新闻进行收藏与评论

### 五、其他功能
其他功能主要放在我的页面中：登录功能入口、用户反馈等。  

## 方案选择

### 传统方案
传统方案需要服务端与客户端开发人员进行沟通，确定交互数据的协议格式。  
服务端负责：搭建业务服务器，进行服务端逻辑代码的编写，提供数据api接口给客户端调用。  
客户端负责：编写界面，使用api接口从服务端读取数据进行数据交互。  

### DroiBaaS方案

#### 一、用户系统
1. `DroiBaaS`提供了`DroiUser`类来帮助开发者建立用户系统
在这里介绍通过继承的方式使用`DroiUser`，这里我创建了一个类`MyUser`继承于`DroiUser`,在这个类中添加一些我们需要的属性，比如：address、icon等属性

    ``` Object-C
@interface MyUser : DroiUser
DroiReference
@property(strong, nonatomic) DroiFile* icon;
DroiExpose
@property(copy, nonatomic) NSString* address;
DroiExpose
@property(copy, nonatomic) NSString *nickName;
@end

    ```

2. 注册用户

    ``` Object-C
    NSString *userName = self.userNameTF.text;
    NSString *password = self.passwordTF.text;
    MyUser *newUser = [[MyUser alloc] init];
    newUser.UserId = userName;
    newUser.Password = password;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [newUser signUpInBackground:^(BOOL result, DroiError *error) {
        if (result) {
        //注册成功会自动登录
            hud.labelText= @"注册成功!";
            [self close:nil];
        }
        else{
            hud.labelText= [NSString stringWithFormat:@"注册失败!%@",error.message];
        }
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:2];
    }];

    ```

3. 登录

    ``` Object-C
    NSString *userName = self.userNameTF.text;
    NSString *password = self.passwordTF.text;
    // 登录時，需传入自定义的对象的名称
    DroiError* error = nil;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    MyUser* user = [MyUser loginByUserClass:userName password:password userClass:[MyUser class] error:&error];
    if (error.isOk && user != nil && [user isAuthorized]) {
        hud.labelText= @"登录成功!";
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        hud.labelText= [NSString stringWithFormat:@"登录失败!%@",error.message];
    }
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:2];
    ```

4. 上传头像

    ``` Object-C
    MyUser *currentUser = [MyUser getCurrentUserByUserClass:[MyUser class]];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DroiError *error = [currentUser.icon updateData:data];
            
            if (error.isOk) {
                [currentUser saveInBackground:^(BOOL result, DroiError *error) {
                    if (result) {
                        hud.labelText = @"上传成功!";
                    }
                    else{
                        hud.labelText = [NSString stringWithFormat: @"上传失败%@",error.message];
                    }
                    hud.mode = MBProgressHUDModeText;
                    [hud hide:YES afterDelay:2];
                }];
            }
            else {
                
                NSLog(@"%@",error.message);
            }

    ```

5. 显示头像

    ``` Object-C
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
    self.userNameLabel.text = currentUser.UserId
    ```

#### 二、首页新闻信息list展示
通过`DroiBaaS`的web控制台可以创建`News`类，并且可以通过增加列的方式增加属性。
可以通过增加行的方式来添加一条数据。
然后需要在客户端创建一个类来对应于`DroiBaaS`云端的数据，如下：

``` Object-C
@interface News : DroiObject

DroiExpose
@property(copy, nonatomic) NSString* newsDescription;
DroiExpose
@property(strong, nonatomic) NSString* smallImage;
DroiExpose
@property(copy, nonatomic) NSString* htmlString;
DroiExpose
@property(copy, nonatomic) NSString* authorName;
DroiExpose
@property(assign, nonatomic) NSInteger tag;
DroiExpose
@property(assign, nonatomic) NSInteger type;
DroiExpose
@property(copy, nonatomic) NSString *contentId;

@end
```

在客户端可以通过`DroiQuery`来查询保存在云端的数据，并且进行展示：

``` Object-C
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

```

#### 三、新闻详情展示
新闻详情为一段hmtl字符串是`News`的一个属性，可以通过 `News`对象来获取，如下：

``` Object-C
NSString *htmlStr = [NSString stringWithFormat:@"<head> </head> <article class=\"typo container\"><div id=\"body\" class=\"fontsizetwo\"><h1 class=\"heading\" id=\"gsTemplateContent_Title\">%@</h2><span class=\"info\" id=\"gsTemplateContent_Subtitle\">作者: %@ </span><hr></hr>%@",self.newsModel.newsDescription,self.newsModel.authorName,self.newsModel.htmlString];
    NSString *str = [self importStyleWithHtmlString:htmlStr];
    [self.webView loadHTMLString:str baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];

```



#### 四、新闻的收藏与评论功能
这个功能用来根据关键字进行一些简单的筛选，同样需要使用`DroiQuery`来查询，同时需要一个关系类来建立联系。
创建关系类`NewsRelation`

``` Object-C
@interface NewsRelation : DroiObject
DroiReference
@property(strong, nonatomic) MyUser* colletUser;
DroiReference
@property(strong, nonatomic) News* news;
DroiExpose
@property(copy, nonatomic) NSString* colletUserId;
DroiExpose
@property(copy, nonatomic) NSString* newsId;
@end
```
收藏功能
``` Object-C
 MyUser *user = [MyUser getCurrentUserByUserClass:[MyUser class]];
    //如果是匿名用户的话 跳转到登陆页面
    if (user.isAnonymous) {
        
        UserLoginViewController *loginVC = [[UserLoginViewController alloc] initWithStyle:LoginStyle];
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }
    
    NSString *newsObjId = self.newsModel.objectId;
    NSString *collectUserId = user.UserId;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NewsRelation *relation = [[NewsRelation alloc] init];
    relation.newsId = newsObjId;
    relation.colletUserId = collectUserId;
    relation.news = self.newsModel;
    relation.colletUser = user;
    [relation saveInBackground:^(BOOL result, DroiError *error) {
        if (error.isOk) {
            hud.labelText = @"收藏成功";
            self.collectBtn.selected = YES;
        }
        else{
            hud.labelText = [NSString stringWithFormat:@"收藏失败%@",error.message];
            NSLog(@"收藏失败%@",error.message);
        }
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
    }];
```

#### 五、其他功能
其他一些功能可以通过在我的页面点击按钮来调用，也有一些功能可以在初始化时添加。  

1. 意见反馈
我们需要通过意见反馈来知道用户对应用的评价，通过点击进入反馈sdk的界面：

    ``` Object-C
        [DroiFeedback callFeedbackWithViewController:self];
    ```

2. 消息推送
通过消息推送增加应用的日活，方便活动的推广等。只需在AppDelegate中添加一行代码即可实现：

    ``` Object-C
    //启用DroiPush
    [DroiPush registerForRemoteNotifications];
    ```
