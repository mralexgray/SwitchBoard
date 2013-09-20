//
//  EndedCallViewController.h
//  Telephone

#import <Cocoa/Cocoa.h>

#import "XSViewController.h"

@class CallController;

@interface EndedCallViewController : XSViewController

// Call controller the receiver belongs to.
@property (nonatomic, weak) CallController *callController;

// Display Name field outlet.
@property (nonatomic, strong) IBOutlet NSTextField *displayedNameField;

// Status field outlet.
@property (nonatomic, strong) IBOutlet NSTextField *statusField;

// Redial button outlet.
@property (nonatomic, strong) IBOutlet NSButton *redialButton;

// Designated initializer.
// Initializes an EndedCallViewController object with a given nib file and call controller.
- (id)initWithNibName:(NSString *)nibName
       callController:(CallController *)callController;

// Redials a call.
- (IBAction)redial:(id)sender;

// Method to be called when |enable redial button| timer fires.
- (void)enableRedialButtonTick:(NSTimer *)theTimer;

@end
