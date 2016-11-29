//
//  UserIconCell.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/15.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "UserIconCell.h"
#import <UIImageView+WebCache.h>

@interface UserIconCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end
@implementation UserIconCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setIcon:(NSURL *)url{
    
    [self.iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Placeholder_Icon"]];
}
@end
