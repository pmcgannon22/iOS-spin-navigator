//
//  MSMainBubbleView.h
//  MSBubbleNavigation
//
//  Created by Patrick McGannon on 7/25/14.
//  Copyright (c) 2014 Patrick McGannon. All rights reserved.
//

#import "MSBubbleView.h"
#import "MSMiniBubbleView.h"

typedef void (^BubbleClickBlock)();

@interface MSMainBubbleView : MSBubbleView

@property (strong, nonatomic) NSMutableArray* bubbles;

- (IBAction)handlePan:(UIPanGestureRecognizer*) recognizer;

- (void)addActionIcon:(NSString*)icon tapCommand:(BubbleClickBlock)command;

@end
