//
//  AKResponsiveProgressIndicator.h
//  Telephone

#import <Cocoa/Cocoa.h>

// Allows progress indicator to send an action message to a target on mouse-up events.
@interface AKResponsiveProgressIndicator : NSProgressIndicator

// The receiver's target.
@property (nonatomic, unsafe_unretained) id target;

// The receiver's action-message selector.
@property (nonatomic, assign) SEL action;

@end
