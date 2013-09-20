//
//  AKNSWindow+Resizing.h
//  Telephone

#import <Cocoa/Cocoa.h>

// A category for window resizing.
@interface NSWindow (AKWindowResizingAdditions)

// Sets |aView| content view for the receiver and resizes the receiver with optional animation.
- (void)ak_resizeAndSwapToContentView:(NSView *)aView animate:(BOOL)performAnimation;

// Calls |ak_resizeAndSwapToContentView:animate:| with |performAnimation| set to NO.
- (void)ak_resizeAndSwapToContentView:(NSView *)aView;

@end
