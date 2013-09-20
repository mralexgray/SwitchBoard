//
//  IncomingCallViewController.h
//  Telephone

#import <Cocoa/Cocoa.h>

#import "XSViewController.h"

@class CallController;

@interface IncomingCallViewController : XSViewController

// Call controller the receiver belongs to.
@property (nonatomic, weak) CallController *callController;

// Display Name field outlet.
@property (nonatomic, strong) IBOutlet NSTextField *displayedNameField;

// Status field outlet.
@property (nonatomic, strong) IBOutlet NSTextField *statusField;

// Accept Call button outlet.
@property (nonatomic, strong) IBOutlet NSButton *acceptCallButton;

// Decline Call button outlet.
@property (nonatomic, strong) IBOutlet NSButton *declineCallButton;

// Designated initializer.
// Initializes an IncomingCallViewController object with a given call controller.
- (id)initWithCallController:(CallController *)callController;

// Accepts an incoming call.
- (IBAction)acceptCall:(id)sender;

// Declines an incoming call.
- (IBAction)hangUpCall:(id)sender;

@end
