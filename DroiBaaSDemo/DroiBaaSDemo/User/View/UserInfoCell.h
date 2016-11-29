//
//  UserInfoCell.h
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/15.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface UserInfoCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@end
