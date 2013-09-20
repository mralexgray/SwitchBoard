//
//  ActiveCallTransferViewController.m
//  Telephone

#import "ActiveCallTransferViewController.h"

#import "AKSIPCall.h"

#import "CallTransferController.h"

@implementation ActiveCallTransferViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[[self displayedNameField] cell] setBackgroundStyle:NSBackgroundStyleLight];
    [[[self statusField] cell] setBackgroundStyle:NSBackgroundStyleLight];
}
- (IBAction)transferCall:(id)sender {
    if (![[self callController] isCallOnHold]) {
        [[self callController] toggleCallHold];
    }
    [(CallTransferController *)[self callController] transferCall];
}
- (IBAction)showCallTransferSheet:(id)sender {
    // Do nothing.
}

#pragma mark -
#pragma mark NSMenuValidation protocol

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    if ([menuItem action] == @selector(showCallTransferSheet:)) {
        return NO;
    }
	return [super validateMenuItem:menuItem];
}

@end
