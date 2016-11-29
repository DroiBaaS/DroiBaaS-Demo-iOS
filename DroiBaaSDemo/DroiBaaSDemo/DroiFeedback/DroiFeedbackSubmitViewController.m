//
//  DroiFeedbackSubmitViewController.m
//  DroiFeedbackDemo
//
//  Created by Jon on 16/6/27.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "DroiFeedbackSubmitViewController.h"
#import "DroiFeedbackRequest.h"
#import "DroiFeedbackConfig.h"
@interface DroiFeedbackSubmitViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIButton *summitBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
@end

@implementation DroiFeedbackSubmitViewController

- (void)dealloc{
    NSLog(@"DroiFeedbackSubmitViewController delloc!");
}

- (instancetype)init{
    
    return [super initWithNibName:@"DroiFeedback.framework/DroiFeedbackSubmitViewController" bundle:[NSBundle mainBundle]];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    self.limitLabel.text = [[NSString alloc] initWithFormat:@"%ld",200 - [textView.text length]];
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    self.placeholderLabel.hidden = YES;

}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.text == nil || [textView.text isEqualToString:@""]) {
        
        self.placeholderLabel.hidden = NO;
    }
    else{
        self.placeholderLabel.hidden = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
    self.textView.delegate = self;
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.textView.layer.cornerRadius = 5;
    self.summitBtn.layer.cornerRadius = 5;
    UIImage *image = [UIImage imageNamed:@"DroiFeedback.framework/FeedbackBack"];
    [self.backButton setImage:image forState:UIControlStateNormal];
}
- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)summit:(UIButton *)sender {

    sender.enabled = NO;
//邮箱或手机号码
    NSString *regex = @"(^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$)|(^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self.textField.text];
    if (!isMatch) {
    
        [self alertWithString:@"请输入正确的联系方式！" completion:^{
            sender.enabled = YES;
        }];
        return;
    }
    if (self.textView.text.length == 0) {

        [self alertWithString:@"请输入您的意见和建议！" completion:^{
            sender.enabled = YES;
        }];
        return;
    }
    if (self.textView.text.length > 200) {
        
        [self alertWithString:@"字数过长！" completion:^{
            sender.enabled = YES;
        }];
        return;
    }
//
    [DroiFeedbackRequest requestToSummitFeedback:self.textView.text contact:self.textField.text callback:^(BOOL sucess, id object) {
        if (sucess) {
            [self alertWithString:@"提交成功！" completion:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else{
            [self alertWithString:@"提交失败！" completion:^{
                sender.enabled = YES;
            }];
        }
    }];
  
}

- (void)alertWithString:(NSString *)alertString completion:(void (^)(void))completion{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:alertString preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:^{
        
        dispatch_after(0, dispatch_get_main_queue(), ^{
            sleep(1);
            [alert dismissViewControllerAnimated:YES completion:completion];
        });
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)setupColor{
    
    self.navigationView.backgroundColor = [DroiFeedbackConfig defaultConfig].color;
    self.summitBtn.backgroundColor = [DroiFeedbackConfig defaultConfig].color;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
