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
        
        MSMiniBubbleView *newBubble2 = [[MSMiniBubbleView alloc] initAtAngle:0.3333*M_PI icon:@"messenger-icon" center:CGPointMake(12, 15) radius:55];
        [_bubbles addObject:newBubble2];
        [self addSubview:newBubble2];
        
        MSMiniBubbleView *newBubble3 = [[MSMiniBubbleView alloc] initAtAngle:0.6666*M_PI icon:@"messenger-icon" center:CGPointMake(12, 15) radius:55];
        [_bubbles addObject:newBubble3];
        [self addSubview:newBubble3];
        
        MSMiniBubbleView *newBubble4 = [[MSMiniBubbleView alloc] initAtAngle:M_PI icon:@"messenger-icon" center:CGPointMake(12, 15) radius:55];
        [_bubbles addObject:newBubble4];
        [self addSubview:newBubble4];
    }
    return self;
}

- (void)addActionIcon:(NSString*)icon tapCommand:(BubbleClickBlock)command
{
    
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

- (void) bubbleTapped: (UITapGestureRecognizer*) recognizer
{
    NSLog(@"tapped main");
    
    [UIView animateWithDuration:0.3f
                          delay:0.1
                        options: UIViewAnimationCurveEaseIn
                     animations:^{
                         CGRect frame = self.frame;
                         frame.origin.x = self.frame.origin.x - 50;
                         self.icon.alpha = 1.0;
                         self.frame = frame;
                     }
                     completion: ^(BOOL finished)
     {
         double r = 55.0;
     }];
}

- (IBAction)handlePan:(UIPanGestureRecognizer*) recognizer {
    CGPoint translation = [recognizer translationInView:self];
    
    float d_theta = translation.y/(110*M_PI);
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        //anims = [[NSMutableArray alloc] init];
        //[CATransaction
        // setValue:[NSNumber numberWithFloat:6.0] forKey:kCATransactionAnimationDuration];
    }
    for (MSMiniBubbleView* b in _bubbles) {
        
        if(recognizer.state == UIGestureRecognizerStateEnded) {
            
            CGPoint velocity = [recognizer velocityInView:self];
            float d_theta = -1 * velocity.y/(110*M_PI);
            [b animateAroundCenter:CGPointMake(35, 35) radius:55 d_theta:d_theta];
            
            NSLog(@"yvel-done=%f", velocity.y);
        }
    }
    if(recognizer.state == UIGestureRecognizerStateEnded) {
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
}

@end
