//
//  HomeTableViewCell.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/6.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "HomeTableViewCell.h"


@interface HomeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *authorIconButton;

@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *weiboDescription;

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setWeiboDeicription:(NSString *)weiboDeicription{
    
    _weiboDeicription = weiboDeicription;
    self.weiboDescription.text = _weiboDeicription;

}

//- (void)setModel:(WeiboModel *)model{
//    _model = model;
//    
//    MyUser *author = _model.author;
//    
//   [author.icon getInBackground:^(NSData *data, DroiError *error) {
//       
//       if (data) {
//           UIImage *icon = [UIImage imageWithData:data];
//           [self.authorIconButton setImage:icon forState:UIControlStateNormal];
//       }
//       else{
//           NSLog(@"获取icon失败:%@", error.message);
//       }
//    }];
//    self.authorNameLabel.text = author.UserId;
//    self.weiboDescription.text = _model.weiboDescription;
//    
//}
@end
