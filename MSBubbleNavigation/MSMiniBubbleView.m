//
//  MSMiniBubbleView.m
//  MSBubbleNavigation
//
//  Created by Patrick McGannon on 7/25/14.
//  Copyright (c) 2014 Patrick McGannon. All rights reserved.
//

#import "MSMiniBubbleView.h"

@implementation MSMiniBubbleView {
    float angle;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initAtAngle:(CGFloat)ang icon:(NSString*)iconImageName center:(CGPoint)center radius:(CGFloat)r
{
    self = [super initWithFrame:CGRectMake(r * cos(ang) + center.x, r * sin(ang + M_PI) + center.y, 40, 40) icon:iconImageName];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleTapped:)]];
    if(self) {
        self->angle = ang;
    }
    return self;
}

- (void) bubbleTapped: (UITapGestureRecognizer*) recognizer
{
    if(self->_tapCommand) {
        self->_tapCommand();
    }
}

- (CGPoint) calculatePosition:(CGPoint)center radius:(float)r
{
    float ang =   fmod(self->angle,2 * M_PI);
    float x = r * cos(ang) + center.x;
    float y = r * -1 * sin(ang) + center.y;
    return CGPointMake(x, y);
}

- (void)changeAngle:(CGFloat)d_theta center:(CGPoint)center radius:(float)r
{
     CGRect frame = self.frame;
     self->angle += d_theta;
     frame.origin = [self calculatePosition:center radius:r];
     self.frame = frame;
}

- (void)moveToAngle:(CGFloat)theta center:(CGPoint)center radius:(float)r
{
    CGRect frame = self.frame;
    self->angle = theta;
    frame.origin = [self calculatePosition:center radius:r];
    self.frame = frame;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self moveToAngle:self->angle center:CGPointMake(12, 15) radius:55];
}

- (void)animateAroundCenter:(CGPoint)center radius:(CGFloat)radius d_theta:(CGFloat)d_theta
{
    KeyframePolarBlock func = ^CGPoint(double ang) {
        float r = 55;
        float x = r * cos(ang) + center.x;
        float y = r * -1 * sin(ang) + center.y;
        return CGPointMake(x, y);
    };
    
    if (self.layer) {
        if(d_theta < 0)
            d_theta = d_theta < 0 ? MAX(d_theta, -1*M_PI) : MIN(d_theta, M_PI);
        
        double endAngle = (self->angle + d_theta*4);
        CAAnimation *drop = [CAKeyframeAnimation
                             animationWithKeyPath:@"position"
                             function:func
                             time:abs(d_theta)
                             fromValue:self->angle toValue:endAngle];
        
        drop.delegate = self;
        [self.layer addAnimation:drop forKey:[NSMutableString stringWithFormat:@"polar"]];
        self->angle = fmod(endAngle,2*M_PI) + 2*M_PI;
    }
    
}

@end
