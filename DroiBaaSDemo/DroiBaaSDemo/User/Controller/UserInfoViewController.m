//
//  UserInfoViewController.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/8.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoCell.h"
#import "UserIconCell.h"
#import "MyUser.h"
#import "HUD.h"
@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UserIconCell nib] forCellReuseIdentifier:[UserIconCell cellReuseIdentifier]];
    [self.tableView registerNib:[UserInfoCell nib] forCellReuseIdentifier:[UserInfoCell cellReuseIdentifier]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


#pragma mark tabelViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyUser *user = [MyUser getCurrentUserByUserClass:[MyUser class]];

    if (indexPath.row == 0) {
      UserIconCell *iconCell = [tableView dequeueReusableCellWithIdentifier:[UserIconCell cellReuseIdentifier] forIndexPath:indexPath];
        [iconCell setIcon:user.icon.getUrl];
        return iconCell;
    }
    UserInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:[UserInfoCell cellReuseIdentifier]  forIndexPath:indexPath];
    if (indexPath.row == 1) {
        infoCell.titleLabel.text= @"昵称";
        infoCell.detailLabel.text = user.nickName;
    }
    if (indexPath.row == 2) {
        infoCell.titleLabel.text= @"修改密码";
        
    }
        return infoCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    return view;
}
#pragma mark tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [self uploadIcon];
    }
    if (indexPath.row == 1) {
        [self updataUserNickName];
    }
    if (indexPath.row == 2) {
        [self updataUserPassword];
    }
    
}



- (IBAction)logout:(id)sender {
    
    MyUser *currentUser = [MyUser getCurrentUserByUserClass:[MyUser class]];
    if (!currentUser.isAnonymous) {
        [currentUser logout];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


//修改密码

-(void)updataUserPassword{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"修改密码" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
   
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入旧密码";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入新密码";
    }];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *oldPassword = [alert.textFields[0] text];
        NSString *newPassword = [alert.textFields[1] text];
        MyUser *user = [MyUser getCurrentUserByUserClass:[MyUser class]];
        [HUD show];
        [user changePasswordInBackground:oldPassword newPassword:newPassword callback:^(BOOL result, DroiError *error) {
            if (result) {
                [HUD showText:@"修改成功"];
                [self.tableView reloadData];
            }
            else{
                [HUD showText:[NSString stringWithFormat:@"修改失败%@",error.message]];
            }
            [HUD dismiss];
        }];

           }];
    [alert addAction:actionCancel];
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)updateUserInfo:(MyUser *)user{
    
    [HUD show];
    [user saveInBackground:^(BOOL result, DroiError *error) {
        if (result) {
            [HUD showText:@"修改成功"];
            [self.tableView reloadData];
        }
        else{
            [HUD showText:[NSString stringWithFormat:@"修改失败%@",error.message]];
        }
        [HUD dismiss];
    }];

}

//更新用户资料
- (void)updataUserNickName{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"输入昵称" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *nickName = [alert.textFields[0] text];
        MyUser *user = [MyUser getCurrentUserByUserClass:[MyUser class]];
        user.nickName = nickName;
        [self updateUserInfo:user];
    }];
    [alert addAction:actionCancel];
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}

// 上传图片
- (void)uploadIcon{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else {
    }
}

#pragma Delegate method UIImagePickerControllerDelegate
//图像选取器的委托方法，选完图片后回调该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]){
        NSData *data;
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage * smallImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(128, 128)];
        if (UIImagePNGRepresentation(smallImage) == nil) {
            data = UIImageJPEGRepresentation(smallImage, 1.0);
            
        } else {
            data = UIImagePNGRepresentation(smallImage);
        }
        [picker dismissViewControllerAnimated:YES completion:^{
            MyUser *currentUser = [MyUser getCurrentUserByUserClass:[MyUser class]];
            currentUser.icon = [DroiFile fileWithData:data];
            [self updateUserInfo:currentUser];
            }];
    }
}

//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
