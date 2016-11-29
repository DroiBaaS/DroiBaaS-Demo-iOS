//
//  HomeCommentCell.h
//  DroiBaaSDemo
//
//  Created by Jon on 16/7/7.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@interface HomeCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (nonatomic , strong) CommentModel  *model;

@end
