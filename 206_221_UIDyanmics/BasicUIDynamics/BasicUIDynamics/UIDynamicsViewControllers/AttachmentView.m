//
//  AttachmentView.m
//  BasicUIDynamics
//
//  Created by ding orlando on 6/23/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "AttachmentView.h"

@implementation AttachmentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
// see, just demo purpose, for production usage, see http://stackoverflow.com/questions/5370557/draw-line-using-cgcontext
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //Get the CGContext from this view
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 1.0f);
    CGContextMoveToPoint(context, self.redSquare.center.x, self.redSquare.center.y);
    CGContextAddLineToPoint(context, self.square.center.x, self.square.center.y);
    CGContextStrokePath(context);
}

@end
