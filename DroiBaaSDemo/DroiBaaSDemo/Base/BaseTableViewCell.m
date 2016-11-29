//
//  BaseTableViewCell.m
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/15.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (UINib *)nib{
    
    return [UINib nibWithNibName:[[self class] description] bundle:nil];
}

+ (NSString *)cellReuseIdentifier{
    
    return [[self class] description];
}
@end
