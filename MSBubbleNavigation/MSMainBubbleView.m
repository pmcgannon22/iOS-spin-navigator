//
//  MSMainBubbleView.m
//  MSBubbleNavigation
//
//  Created by Patrick McGannon on 7/25/14.
//  Copyright (c) 2014 Patrick McGannon. All rights reserved.
//

#import "MSMainBubbleView.h"

@implementation MSMainBubbleView {
    BOOL active;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame icon:(NSString *)iconImageName
{
    self = [super initWithFrame:frame icon:iconImageName];
    self->active = NO;
    if(self) {
        self.icon.alpha = 0.6;
        _bubbles = [[NSMutableArray alloc] init] ;

    }
    return self;
}

- (void)addActionIcon:(NSString*)icon tapCommand:(BubbleClickBlock)command
{
    NSUInteger c = MAX(_bubbles.count, 1);
    float step = M_PI/(c);
    //FIX TO NOT BE DTHETA
    for(int i=0; i<_bubbles.count; i++) {
        [_bubbles[i] moveToAngle:i*step+M_PI/2 center:CGPointMake(12, 15) radius:55];
    }
    
    MSMiniBubbleView *action = [[MSMiniBubbleView alloc] initAtAngle:(c*step + M_PI/2) icon:icon center:CGPointMake(12, 15) radius:55];
    action.tapCommand = command;
    
    [_bubbles addObject:action];
    [self addSubview:action];
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    for(UIView* subview in self.subviews)
    {
        UIView *view = [subview hitTest:[self convertPoint:point toView:subview] withEvent:event];
        if(view) return view;
    }
    return [super hitTest:point withEvent:event];
}

- (void) notifyActive
{
    CABasicAnimation *notifyAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    notifyAnimation.duration = 0.5f;
    notifyAnimation.autoreverses = YES;
    notifyAnimation.repeatCount = 2;
    notifyAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.icon.layer addAnimation:notifyAnimation forKey:@"notifyActive"];
}

- (void) bubbleTapped: (UITapGestureRecognizer*) recognizer
{
    
    [UIView animateWithDuration:0.3f
                          delay:0.1
                        options: UIViewAnimationCurveEaseIn
                     animations:^{
                         CGRect frame = self.frame;
                         if(self->active) {
                             frame.origin.x = self.frame.origin.x + 50;
                             self.icon.alpha = 1.0;
                         } else {
                             frame.origin.x = self.frame.origin.x - 50;
                             self.icon.alpha = 0.6;
                         }

                         self.frame = frame;
                     }
                     completion: ^(BOOL finished)
                    {
                        self->active = !self->active;
                        for(MSMiniBubbleView* b in _bubbles)
                        {
                            [b setHidden:!self->active];
                        }
                    }
                ];
}

- (IBAction)handlePan:(UIPanGestureRecognizer*) recognizer {
    CGPoint translation = [recognizer translationInView:self];
    
    for (MSMiniBubbleView* b in _bubbles) {
        if(recognizer.state == UIGestureRecognizerStateEnded) {
            CGPoint velocity = [recognizer velocityInView:self];
            float d_theta = -1 * velocity.y/(110*M_PI);
            [b animateAroundCenter:CGPointMake(35, 35) radius:55 d_theta:d_theta];
        } else {
            float d_theta = translation.y/(110*M_PI);
            [b changeAngle:d_theta center:CGPointMake(12, 15) radius:55];
        }
    }
    if(recognizer.state == UIGestureRecognizerStateEnded) {
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
}

@end
