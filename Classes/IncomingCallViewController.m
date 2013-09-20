//
//  IncomingCallViewController.m
//  Telephone
//

#import "IncomingCallViewController.h"

#import "AppController.h"
#import "CallController.h"

@implementation IncomingCallViewController

@synthesize callController = callController_;

- (id)initWithCallController:(CallController *)callController {
    self = [super initWithNibName:@"IncomingCallView" bundle:nil windowController:callController];
	if (self != nil) {
        [self setCallController:callController];
    }
    return self;
}
- (id)init {
    NSString *reason = @"Initialize IncomingCallViewController with initWithCallController:";
    @throw [NSException exceptionWithName:@"AKBadInitCall" reason:reason userInfo:nil];
    return nil;
}
- (void)removeObservations {
    [[self displayedNameField] unbind:NSValueBinding];
    [[self statusField] unbind:NSValueBinding];
    [super removeObservations];
}
- (void)awakeFromNib {
    [[[self displayedNameField] cell] setBackgroundStyle:NSBackgroundStyleRaised];
    [[[self statusField] cell] setBackgroundStyle:NSBackgroundStyleRaised];
}
- (IBAction)acceptCall:(id)sender {
    [[self callController] acceptCall];
}
- (IBAction)hangUpCall:(id)sender {
    [[self callController] hangUpCall];
}

#pragma mark - NSMenuValidation protocol

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    if ([menuItem action] == @selector(hangUpCall:)) {
        [menuItem setTitle:NSLocalizedString(@"Decline", @"Decline. Call menu item.")];
    }
	return YES;
}

@end
