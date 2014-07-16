//
//  MSBubbleView.h
//  MSBubbleNavigation
//
//  Created by Patrick McGannon on 7/14/14.
//  Copyright (c) 2014 Patrick McGannon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSBubbleIconView.h"


@interface MSBubbleView : UIView

+ (BOOL) isActive;

@property (strong, nonatomic) MSBubbleIconView *icon;

- (id)initWithWindow:(UIWindow*)window;

@end
