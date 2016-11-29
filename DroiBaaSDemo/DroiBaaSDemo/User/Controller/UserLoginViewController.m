//  UserLoginViewController.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/7.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "UserLoginViewController.h"
#import "MyUser.h"
#import "DroiLog.h"
#import "HUD.h"
@interface UserLoginViewController ()

@property (assign, nonatomic)UserLoginViewControllerStyle style;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmPasswordHeight;

@property (weak, nonatomic) IBOutlet UIButton *loginOrRegisterButton;

@property (weak, nonatomic) IBOutlet UIButton *changeStyleButton;

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation UserLoginViewController

- (instancetype)initWithStyle:(UserLoginViewControllerStyle )style{
    if (self = [super initWithNibName:@"UserLoginViewController" bundle:nil]) {
        self.style = style;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.loginOrRegisterButton.layer.borderWidth = 1;
    self.loginOrRegisterButton.layer.borderColor = [[UIColor whiteColor] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)loginOrRegister:(id)sender {
    
    switch (self.style) {
        case LoginStyle:
            [self login];
            break;
        case RegisterStyle:
            [self registerUser];
            break;
        default:
            break;
    }
}

//用户注册
- (void)registerUser{
    
    NSString *userName = self.userNameTF.text;
    NSString *password = self.passwordTF.text;
    MyUser *newUser = [[MyUser alloc] init];
    newUser.UserId = userName;
    newUser.Password = password;
    [HUD show];
    [newUser signUpInBackground:^(BOOL result, DroiError *error) {
        if (result) {
        //注册成功会自动登录
        [HUD showText:@"注册成功!"];
            [self close:nil];
        }
        else{
            [HUD showText:[NSString stringWithFormat:@"注册失败!%@",error.message]];
        }
        [HUD dismiss];
    }];
}

//用户登录
- (void)login{
    
    NSString *userName = self.userNameTF.text;
    NSString *password = self.passwordTF.text;
    // 登录時，需传入自定义的对象的名称
    DroiError* error = nil;
    [HUD show];
    MyUser* user = [MyUser loginByUserClass:userName password:password userClass:[MyUser class] error:&error];
    if (error.isOk && user != nil && [user isAuthorized]) {
        [HUD showText:@"登录成功!"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [HUD showText:[NSString stringWithFormat:@"登录失败!%@",error.message]];
    }
    [HUD dismiss];

}


- (IBAction)changeStyle:(id)sender {
    
    switch (_style) {
        case LoginStyle:
            self.style = RegisterStyle;
            break;
        case RegisterStyle:
            self.style = LoginStyle;
            break;
        default:
            break;
    }
}

- (void)setStyle:(UserLoginViewControllerStyle)style{
    
    if (_style == style) {
        return;
    }
    _style = style;
    [self setupLayoutWihtStyle:_style];
}


- (void)setupLayoutWihtStyle:(UserLoginViewControllerStyle )style{
    
    switch (style) {
        case LoginStyle:
        {
            self.confirmPasswordHeight.constant = 0.0;
            [self.loginOrRegisterButton setTitle:@"登录" forState:UIControlStateNormal];
            [self.changeStyleButton setTitle:@"还没有账号?创建一个" forState:UIControlStateNormal];
        }
            break;
        case RegisterStyle:
        {
            self.confirmPasswordHeight.constant = 30.0;
            [self.loginOrRegisterButton setTitle:@"注册" forState:UIControlStateNormal];
            [self.changeStyleButton setTitle:@"已经注册?登录" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.5 animations:^{
    [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
