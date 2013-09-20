//
//  AKNSWindow+Resizing.m
//  Telephone

#import "AKNSWindow+Resizing.h"

@implementation NSWindow (AKWindowResizingAdditions)

- (void)ak_resizeAndSwapToContentView:(NSView *)aView animate:(BOOL)performAnimation {
    // Compute view size delta.
    NSSize currentSize = [[self contentView] frame].size;
    NSSize newSize = [aView frame].size;
    CGFloat deltaWidth = newSize.width - currentSize.width;
    CGFloat deltaHeight = newSize.height - currentSize.height;
	// Compute new window size.
    NSRect windowFrame = [self frame];
    windowFrame.size.height += deltaHeight;
    windowFrame.origin.y -= deltaHeight;
    windowFrame.size.width += deltaWidth;
	// Show temp view while changing views.
    NSView *tempView = [[NSView alloc] initWithFrame:[[self contentView] frame]];
    [self setContentView:tempView];
	// Set new window frame.
    [self setFrame:windowFrame display:YES animate:performAnimation];
	// Swap to the new view.
    [self setContentView:aView];
}
- (void)ak_resizeAndSwapToContentView:(NSView *)aView {
    [self ak_resizeAndSwapToContentView:aView animate:NO];
}

@end
