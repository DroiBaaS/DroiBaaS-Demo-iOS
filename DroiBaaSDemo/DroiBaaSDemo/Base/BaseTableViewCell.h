//
//  BaseTableViewCell.h
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/15.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

+ (UINib *)nib;

+ (NSString *)cellReuseIdentifier;

@end
