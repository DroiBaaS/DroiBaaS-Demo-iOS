//
//  DroiFeedbackCell.m
//  DroiFeedbackDemo
//
//  Created by Jon on 16/6/27.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "DroiFeedbackCell.h"

@interface DroiFeedbackCell ()
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *reply;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@end
@implementation DroiFeedbackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DroiFeedbackModel *)model{
    _model = model;
    self.content.text = model.content;
    self.createTime.text = model.createTime;
    self.reply.text = model.reply ? model.reply:@"感谢您的热心反馈，我们会在第一时间回复您。";
}

//+ (CGFloat)cellHightWithModel:(DroiFeedbackModel *)model{
//    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
//    CGFloat contentWidth = screenWidth - 8 * 2;
//    
//    CGSize contentSize =
//    
//    
//    return 10;
//}

+ (CGSize)boundingRectWithSize:(CGSize)size string:(NSString *)string
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    
    CGSize retSize = [string boundingRectWithSize:size
                                          options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    
    return retSize;
}

@end
