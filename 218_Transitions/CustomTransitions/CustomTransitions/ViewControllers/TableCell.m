//
//  TableCell.m
//  CustomTransitions
//
//  Created by ding orlando on 6/28/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "TableCell.h"

const float iSelectDelay = 500;

@implementation TableCell

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 * see http://stackoverflow.com/questions/11920156/custom-uitableviewcell-selection-style
 **/
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        self.textLabel.textColor = [UIColor whiteColor];
    } else {
        // desc - postpone for displaying - http://stackoverflow.com/questions/4007023/blocks-instead-of-performselectorwithobjectafterdelay
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_MSEC * iSelectDelay),
                       dispatch_get_main_queue(),
                       ^void (void){
                           self.textLabel.textColor = [UIColor blackColor];
                       });
    }
}

@end
