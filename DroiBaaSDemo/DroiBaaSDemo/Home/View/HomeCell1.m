//
//  HomeCell1.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/7.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "HomeCell1.h"
#import <UIImageView+WebCache.h>
@interface HomeCell1 ()

@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsDescription;
@property (weak, nonatomic) IBOutlet UILabel *createUserName;

@end

@implementation HomeCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(News *)model{
    if (_model == model) {
        return;
    }
    _model = model;
    self.newsDescription.text = _model.newsDescription;
    self.createUserName.text = _model.authorName;
    [self.smallImageView sd_setImageWithURL:[NSURL URLWithString:_model.smallImage] placeholderImage:[UIImage imageNamed:@"Placeholder_Image"]];

}
@end
