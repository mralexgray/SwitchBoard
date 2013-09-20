//
//  CallTransferController.h
//  Telephone

#import <Cocoa/Cocoa.h>

#import "ActiveAccountTransferViewController.h"
#import "CallController.h"

// Call transfer controller.
@interface CallTransferController : CallController

// Designated initializer.
// Initializes a CallTransferController with a given call controller.
- (id)initWithSourceCallController:(CallController *)callController;

// Transfers source call controller's call to the receiver's call.
- (void)transferCall;

// Closes a sheet.
- (IBAction)closeSheet:(id)sender;

// Hangs up call and shows initial state.
- (IBAction)showInitialState:(id)sender;

@end
