//
//  CallController.h
//  Telephone

#import <Cocoa/Cocoa.h>

#import "XSWindowController.h"

// Notifications.
//
// Sent when call window is about to be closed.
// |accountController| will be subscribed to this notification in its setter.
extern NSString * const AKCallWindowWillCloseNotification;

@class AccountController, AKSIPCall, AKResponsiveProgressIndicator, AKSIPURI;
@class IncomingCallViewController, ActiveCallViewController;
@class EndedCallViewController, CallTransferController;

// A call controller.
@interface CallController : XSWindowController {
  @protected
    ActiveCallViewController *_activeCallViewController;
    EndedCallViewController *_endedCallViewController;
}

// The receiver's identifier.
@property (nonatomic, copy) NSString *identifier;

// Call controlled by the receiver.
@property (nonatomic, strong) AKSIPCall *call;

// Account controller the receiver belongs to.
@property (nonatomic, weak) AccountController *accountController;

// Call transfer controller.
@property (nonatomic, readonly) CallTransferController *callTransferController;

// Incoming call view controller.
@property (nonatomic, readonly) IncomingCallViewController *incomingCallViewController;

// Active call view controller.
@property (weak, nonatomic, readonly) ActiveCallViewController *activeCallViewController;

// Ended call view controller.
@property (weak, nonatomic, readonly) EndedCallViewController *endedCallViewController;

// Remote party dislpay name.
@property (nonatomic, copy) NSString *displayedName;

// Call status.
@property (nonatomic, copy) NSString *status;

// Remote party name from the Address Book.
@property (nonatomic, copy) NSString *nameFromAddressBook;

// Remote party label from the Address Book.
@property (nonatomic, copy) NSString *phoneLabelFromAddressBook;

// Call destination entered by a user.
@property (nonatomic, copy) NSString *enteredCallDestination;

// SIP URI for the redial.
@property (nonatomic, copy) AKSIPURI *redialURI;

// Timer to display intermediate call status. This status appears for the short period of time and then is being
// replaced with the current call status.
@property (nonatomic, weak) NSTimer *intermediateStatusTimer;

// Call start time.
@property (nonatomic, assign) NSTimeInterval callStartTime;

// A Boolean value indicating whether the receiver's call is on hold.
@property (nonatomic, assign, getter=isCallOnHold) BOOL callOnHold;

// A Boolean value indicating whether the receiver's call is active.
@property (nonatomic, assign, getter=isCallActive) BOOL callActive;

// A Boolean value indicating whether the receiver's call is unhandled.
@property (nonatomic, assign, getter=isCallUnhandled) BOOL callUnhandled;

// Designated initializer.
// Initializes a CallController object with a given nib file and account controller.
- (id)initWithWindowNibName:(NSString *)windowNibName accountController:(AccountController *)anAccountController;

// Accepts an incoming call.
- (void)acceptCall;

// Hangs up a call.
- (void)hangUpCall;

// Redials a call.
- (void)redial;

// Toggles call hold.
- (void)toggleCallHold;

// Toggles microphone mute.
- (void)toggleMicrophoneMute;

// Sets intermediate call status. This status appears for the short period of time and then is being replaced with the
// current call status.
- (void)setIntermediateStatus:(NSString *)newIntermediateStatus;

// Method to be called when intermediate call status timer fires.
- (void)intermediateStatusTimerTick:(NSTimer *)theTimer;

@end
