//
//  MSBubbleView.m
//  MSBubbleNavigation
//
//  Created by Patrick McGannon on 7/14/14.
//  Copyright (c) 2014 Patrick McGannon. All rights reserved.
//

#import "MSBubbleView.h"

static BOOL active;

@implementation MSBubbleView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andIcon:(NSString*)iconImageName
{
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        
        _icon = [[MSBubbleIconView alloc] initWithFrame:CGRectInset(self.bounds, 4, 4)];
        _icon.backgroundColor = [UIColor clearColor];
        
        [_icon setIconImage:[UIImage imageNamed:iconImageName]];
        _icon.alpha = 0.6;
        _icon.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        [self addSubview:_icon];
    }
    return self;
}

// Initialize the center bubble
- (id)initWithWindow:(UIWindow*)window
{
    CGFloat radius = 35;
    CGFloat x = window.bounds.size.width - radius + 10;
    CGFloat y = 150;
    self = [self initWithFrame:CGRectMake(x, y, radius*2, radius*2) andIcon:@"gray.png"];
    if(self) {
        [window addSubview:self];
    }

    return self;
}

+ (BOOL) isActive { return active; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    
    switch([allTouches count])
    {
        case 1: {
            UITouch *touch = [[allTouches allObjects] objectAtIndex: 0];
            CGPoint point = [touch locationInView:self];
            
            
            if (CGRectContainsPoint(self.bounds, point) && ![MSBubbleView isActive]) {
                [UIView animateWithDuration:0.3f
                                    delay:0.1
                                    options: UIViewAnimationCurveEaseIn
                                    animations:^{
                                     CGRect frame = self.frame;
                                     frame.origin.x = self.frame.origin.x - 50;
                                     _icon.alpha = 1.0;
                                     self.frame = frame;
                                 }
                                 completion: ^(BOOL finished)
                                {
                                    active = true;
                                    MSBubbleView *newBubble = [[MSBubbleView alloc] initWithFrame:CGRectMake(20, -40, 40, 40) andIcon:@"messenger-icon.png"];
                                    
                                    [self addSubview:newBubble];
                                    
                                    MSBubbleView *newBubble2 = [[MSBubbleView alloc] initWithFrame:CGRectMake(-35, -20, 40, 40) andIcon:@"messenger-icon.png"];
                                    [self addSubview:newBubble2];
                                    
                                    MSBubbleView *newBubble3 = [[MSBubbleView alloc] initWithFrame:CGRectMake(-35, 45, 40, 40) andIcon:@"messenger-icon.png"];
                                    [self addSubview:newBubble3];
                                    
                                    MSBubbleView *newBubble4 = [[MSBubbleView alloc] initWithFrame:CGRectMake(20, 70, 40, 40) andIcon:@"messenger-icon.png"];
                                    [self addSubview:newBubble4];
                                }];
            } else if ([MSBubbleView isActive]) {
                active = false;
                [UIView animateWithDuration:0.3f
                                      delay:0.1
                                    options: UIViewAnimationCurveEaseOut
                                 animations:^{
                                     CGRect frame = self.frame;
                                     frame.origin.x = self.frame.origin.x + 50;
                                     _icon.alpha = 0.6;
                                     self.frame = frame;
                                 }
                                 completion: ^(BOOL finished)
                                {
                                    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                                }];
            }
            
            NSLog(@"x=%f", point.x);
            NSLog(@"y=%f", point.y);
        }

    }
}


@end
