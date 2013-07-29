//
//  WeiboItemCell.m
//  MultiTaskforSina
//
//  Created by ding orlando on 7/21/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "WeiboItemCell.h"

@implementation WeiboItemCell

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

// desc - dynamically add constraints on UI
//- (void)layoutSubviews{
//    NSLog(@"%@", self.content.text);
//    CGRect _frame = self.content.frame;
//    _frame.size.height += 80;
//    self.content.frame = _frame;
//    [super layoutSubviews];
//}

// desc - may need for navigation
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
