//
//  CAKeyframeAnimation+Polar.h
//  MSBubbleNavigation
//
//  Created by Patrick McGannon on 7/22/14.
//  Copyright (c) 2014 Patrick McGannon. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef CGPoint (^KeyframePolarBlock)(double);

@interface CAKeyframeAnimation (Polar)

+ (id)animationWithKeyPath:(NSString*) path
                function:(KeyframePolarBlock)block
                      time:(double)time
                fromValue:(double)fromValue
                   toValue:(double)toValue;

@end
