//
//  HomeCommentCell.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/7.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "HomeCommentCell.h"
#import <UIButton+WebCache.h>
@interface HomeCommentCell ()

@property (weak, nonatomic) IBOutlet UIButton *userIconButton;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;



@end
@implementation HomeCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CommentModel *)model{
    
    if (_model == model) {
        return;
    }
    _model = model;
    self.userNameLabel.text = _model.author.nickName ?_model.author.nickName : (_model.author.UserId ? _model.author.UserId :@"匿名用户");
    
    self.commentLabel.text = _model.comment;
    [self.userIconButton sd_setBackgroundImageWithURL:_model.author.icon.getUrl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Placeholder_Icon"]];
}
@end
