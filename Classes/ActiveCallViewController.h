//
//  ActiveCallViewController.h
//  Telephone

#import <Cocoa/Cocoa.h>

#import "AKActiveCallView.h"
#import "XSViewController.h"

@class AKResponsiveProgressIndicator, CallController;

@interface ActiveCallViewController : XSViewController <AKActiveCallViewDelegate>

// Call controller the receiver belongs to.
@property (nonatomic, weak) CallController *callController;

// Timer to present call duration time.
@property (nonatomic, weak) NSTimer *callTimer;

// DTMF digits entered by a user.
@property (nonatomic, strong) NSMutableString *enteredDTMF;

// Tracking area to monitor a mouse hovering call progress indicator. When mouse enters that area, progress indicator
// is being replaced with hang-up button.
@property (nonatomic, strong) NSTrackingArea *callProgressIndicatorTrackingArea;

// Display Name field outlet.
@property (nonatomic, strong) IBOutlet NSTextField *displayedNameField;

// Status field outlet.
@property (nonatomic, strong) IBOutlet NSTextField *statusField;

// Call progress indicator outlet.
@property (nonatomic, strong) IBOutlet AKResponsiveProgressIndicator *callProgressIndicator;

// Hang-up button outlet.
@property (nonatomic, strong) IBOutlet NSButton *hangUpButton;

// Hang-up button outlet.
@property (nonatomic, strong) IBOutlet NSSegmentedControl *mediaFlowControl;

// Designated initializer.
// Initializes an ActiveCallViewController object with a given nib file and call controller.
- (id)initWithNibName:(NSString *)nibName callController:(CallController *)callController;

// Hangs up call.
- (IBAction)hangUpCall:(id)sender;

// Toggles call hold.
- (IBAction)toggleCallHold:(id)sender;

// Toggles microphone mute.
- (IBAction)toggleMicrophoneMute:(id)sender;

// Shows call transfer sheet.
- (IBAction)showCallTransferSheet:(id)sender;

// Starts call timer.
- (void)startCallTimer;

// Stops call timer.
- (void)stopCallTimer;

// Method to be called when call timer fires.
- (void)callTimerTick:(NSTimer *)theTimer;

- (IBAction)mediaFlowClick:(id)sender;

@end
