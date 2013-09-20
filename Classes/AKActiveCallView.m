//
//  AKActiveCallView.m
//  Telephone

#import "AKActiveCallView.h"
@implementation AKActiveCallView		- (BOOL)acceptsFirstResponder {	return YES; }

- (void)insertText:(id)aString {  	[self.delegate respondsToSelector:@selector(activeCallView:didReceiveText:)] ?
									[self.delegate activeCallView:self didReceiveText:aString] : nil;
}
- (void)keyDown:(NSEvent *)theEvent {

    NSCharacterSet  * DTMFCharacterSet 		= [NSCharacterSet characterSetWithCharactersInString:@"0123456789*#"],
    				* commandsCharacterSet 	= [NSCharacterSet characterSetWithCharactersInString:@"mh"];
    unichar firstCharacter 					= [theEvent.characters characterAtIndex:0];
	
    if ([DTMFCharacterSet characterIsMember:firstCharacter])  [theEvent isARepeat] ?: [self interpretKeyEvents:@[theEvent]];
	// We want to get DTMF string as text.
    else if ([commandsCharacterSet characterIsMember:firstCharacter]) {
        if (![theEvent isARepeat]) {
            // Pass call control commands further so that main menu will catch them.
            // The corresponding key equivalents must be set in the main menu.
            // We need this because we have key equivalents without modifiers,
            // in which case NSApplication can't recognize them and can't dispatch
            // appropriate events before we even get here.
            [super keyDown:theEvent];
        }
    } else [super keyDown:theEvent]; 
}

@end
