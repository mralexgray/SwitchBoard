//
//  EndedCallViewController.m
//  Telephone

#import "EndedCallViewController.h"

#import "CallController.h"

@implementation EndedCallViewController

- (id)initWithNibName:(NSString *)nibName callController:(CallController *)callController {
    self = [super initWithNibName:nibName bundle:nil windowController:callController];
	if (self != nil) {
        [self setCallController:callController];
    }
    return self;
}
- (id)init {
    NSString *reason = @"Initialize EndedCallViewController with initWithCallController:";
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
- (IBAction)redial:(id)sender {
    [[self callController] redial];
}
- (void)enableRedialButtonTick:(NSTimer *)theTimer {
    [[self redialButton] setEnabled:YES];
}

@end
