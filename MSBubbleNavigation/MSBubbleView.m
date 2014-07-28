//
//  MSBubbleView.m
//  MSBubbleNavigation
//
//  Created by Patrick McGannon on 7/14/14.
//  Copyright (c) 2014 Patrick McGannon. All rights reserved.
//

#import "MSBubbleView.h"
#import "math.h"
#import "CAKeyframeAnimation+Polar.h"

static BOOL active;

@implementation MSBubbleView 


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}



// Initialize the center bubble
- (id)initWithWindow:(UIWindow*)window
{
    CGFloat radius = 35;
    CGFloat x = window.bounds.size.width - radius + 10;
    CGFloat y = 150;
    self = [self initWithFrame:CGRectMake(x, y, radius*2, radius*2) icon:@"gray.png"];
    if(self) {
        [window addSubview:self];
    }

    return self;
}

- (id)initWithFrame:(CGRect)frame icon:(NSString*)iconImageName
{
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        
        _icon = [[MSBubbleIconView alloc] initWithFrame:CGRectInset(self.bounds, 4, 4)];
        _icon.backgroundColor = [UIColor clearColor];
        
        [_icon setIconImage:[UIImage imageNamed:iconImageName]];
        _icon.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        [self addSubview:_icon];
    }
    return self;
}

- (void) bubbleTapped: (UITapGestureRecognizer*) recognizer
{
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}


@end
