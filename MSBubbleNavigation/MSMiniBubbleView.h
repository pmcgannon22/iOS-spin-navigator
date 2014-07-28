//
//  MSMiniBubbleView.h
//  MSBubbleNavigation
//
//  Created by Patrick McGannon on 7/25/14.
//  Copyright (c) 2014 Patrick McGannon. All rights reserved.
//

#import "MSBubbleView.h"
#import "MSMainBubbleView.h"

typedef void (^BubbleClickBlock)();

@interface MSMiniBubbleView : MSBubbleView

@property (strong, nonatomic) BubbleClickBlock tapCommand;

- (id)initAtAngle:(CGFloat)angle icon:(NSString*)iconImageName center:(CGPoint)center radius:(CGFloat)r;

- (void) changeAngle:(CGFloat)d_theta center:(CGPoint)center radius:(float)r;

- (CGPoint) calculatePosition:(CGPoint)center radius:(float)r;

- (void) animateAroundCenter:(CGPoint)center radius:(CGFloat)radius d_theta:(CGFloat)d_theta;

@end
