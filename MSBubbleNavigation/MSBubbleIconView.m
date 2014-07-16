//
//  MSBubbleIconView.m
//  MSBubbleNavigation
//
//  Created by Patrick McGannon on 7/15/14.
//  Copyright (c) 2014 Patrick McGannon. All rights reserved.
//

#import "MSBubbleIconView.h"

@implementation MSBubbleIconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,2);
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.7f;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGRect bound = self.bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGPathRef circle = CGPathCreateWithEllipseInRect(bound, 0);
    CGMutablePathRef invCircle = CGPathCreateMutableCopy(circle);
    CGPathAddRect(invCircle, nil, CGRectInfinite);
    
    CGContextSaveGState(context); {
        CGContextBeginPath(context);
        CGContextAddPath(context, circle);
        CGContextClip(context);
        [_iconImage drawInRect:bound];
    } CGContextRestoreGState(context);
    
    CGContextSaveGState(context); {
        CGContextBeginPath(context);
        CGContextAddPath(context, circle);
        CGContextClip(context);
        CGContextSetShadowWithColor(context, CGSizeMake(0,0), 3.0f, [UIColor colorWithRed:0.994 green:0.989 blue:1.000 alpha:1].CGColor);
        CGContextBeginPath(context);
        CGContextAddPath(context, invCircle);
        CGContextEOFillPath(context);
    } CGContextRestoreGState(context);
    
    CGPathRelease(circle);
    CGPathRelease(invCircle);
    
    CGContextRestoreGState(context);
}


@end
