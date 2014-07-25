//
//  CAKeyframeAnimation+Polar.m
//  MSBubbleNavigation
//
//  Created by Patrick McGannon on 7/22/14.
//  Copyright (c) 2014 Patrick McGannon. All rights reserved.
//

#import "CAKeyframeAnimation+Polar.h"


@implementation CAKeyframeAnimation (Polar)

+(id)animationWithKeyPath:(NSString*)path
                function:(KeyframePolarBlock)block
                     time:(double)time
                fromValue:(double)fromValue
                  toValue:(double)toValue {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path];
    
    
    NSUInteger steps = 100;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:steps];
    double t = 0.0;
    time = MAX(1.0, time);
    double timeStep = time / (double)(steps - 1);
    
    for(NSUInteger i = 0; i < steps; i++) {
        double theta = fromValue + (t/time) * (fromValue - toValue);
        CGPoint pt = block(theta);
        [values addObject:[NSValue valueWithCGPoint:pt]];
        t += timeStep;
    }
    
    animation.calculationMode = kCAAnimationLinear;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setValues:values];
    [animation setDuration:time];
    return animation;
}

@end


