//
//  AKSIPCall.h
//  Telephone

#import <Foundation/Foundation.h>
#import <pjsua-lib/pjsua.h>

extern const NSInteger kAKSIPCallsMax;

typedef NS_ENUM(NSUInteger, AKSIPCallState) {

    kAKSIPCallNullState =         PJSIP_INV_STATE_NULL,     	// Before INVITE is sent or received.
    kAKSIPCallCallingState =      PJSIP_INV_STATE_CALLING, 		// After INVITE is sent.
    kAKSIPCallIncomingState =     PJSIP_INV_STATE_INCOMING,    	// After INVITE is received.
    kAKSIPCallEarlyState =        PJSIP_INV_STATE_EARLY,    	// After response with To tag.
    kAKSIPCallConnectingState =   PJSIP_INV_STATE_CONNECTING,   // After 2xx is sent/received.
    kAKSIPCallConfirmedState =    PJSIP_INV_STATE_CONFIRMED,    // After ACK is sent/received.
    kAKSIPCallDisconnectedState = PJSIP_INV_STATE_DISCONNECTED   // Session is terminated.
};

																	// Notifications.
extern NSString * const AKSIPCallCallingNotification; 				// Calling. After INVITE is sent.
																	// Incoming. After INVITE is received.
extern NSString * const AKSIPCallIncomingNotification;				// Delegate is not subscribed to this notification.
																	// Early. After response with To tag.
extern NSString * const AKSIPCallEarlyNotification;					// Keys: @"AKSIPEventCode", @"AKSIPEventReason".
extern NSString * const AKSIPCallConnectingNotification;			// Connecting. After 2xx is sent/received.
extern NSString * const AKSIPCallDidConfirmNotification;			// Confirmed. After ACK is sent/received.
extern NSString * const AKSIPCallDidDisconnectNotification;			// Disconnected. Session is terminated.
extern NSString * const AKSIPCallMediaDidBecomeActiveNotification;	// Call media is active.
extern NSString * const AKSIPCallDidLocalHoldNotification;			// Call media is put on hold by local endpoint.
extern NSString * const AKSIPCallDidRemoteHoldNotification;			// Call media is put on hold by remote endpoint.
extern NSString * const AKSIPCallTransferStatusDidChangeNotification;	// Call transfer status changed.  Key: @"AKFinalTransferNotification".

@class AKSIPAccount, AKSIPURI, AKSIPCallMediaFlow;
@interface AKSIPCall : NSObject 									// A class representing a SIP call.

// Designated initializer - Initializes a AKSIPCall object with a given SIP account and identifier.
- (id)initWithSIPAccount:(AKSIPAccount *)anAccount identifier:(NSInteger)anIdentifier;

//	AtoZ Custom Methods
- (void) record;	- (void) play;  - (void) say:(NSString*) words;

@property (nonatomic, unsafe_unretained)       id   delegate;		// The receiver's delegate.
@property (nonatomic, assign) 		    NSInteger   identifier;		// The receiver's identifier.
@property (nonatomic, copy) 			 AKSIPURI * localURI;		// SIP URI of the local Contact header.
@property (nonatomic, copy) 		     AKSIPURI * remoteURI;		// SIP URI of the remote Contact header.
@property (assign) 				   AKSIPCallState   state;			// Call state.
@property (copy) 						 NSString * stateText;		// Call state text.
@property (assign) 						NSInteger   lastStatus;		// Call's last status code.
@property (copy) 						 NSString * lastStatusText;	// Call's last status text.
@property (assign) 						NSInteger   transferStatus; // Call transfer status code.
@property (copy) 					     NSString * transferStatusText; // Call transfer status text.

@property (nonatomic, weak)  		 AKSIPAccount * account;		// The account the call belongs to.
@property (nonatomic, strong)  AKSIPCallMediaFlow * mediaFlow;

// A Boolean value indicating whether the call is active, i.e. it has active
// INVITE session and the INVITE session has not been disconnected.
@property (nonatomic, readonly, assign, getter=isActive) BOOL active;
// A Boolean value indicating whether the call has a media session.
@property (nonatomic, readonly, assign) BOOL hasMedia;
// A Boolean value indicating whether the call's media is active.
@property (nonatomic, readonly, assign) BOOL hasActiveMedia;
// A Boolean value indicating whether the call is incoming.
@property (assign, getter=isIncoming) BOOL incoming;
// A Boolean value indicating whether microphone is muted.
@property (nonatomic, assign, getter=isMicrophoneMuted) BOOL microphoneMuted;
// A Boolean value indicating whether the call is on local hold.
@property (nonatomic, readonly, assign, getter=isOnLocalHold) BOOL onLocalHold;
// A Boolean value indicating whether the call is on remote hold.
@property (nonatomic, readonly, assign, getter=isOnRemoteHold) BOOL onRemoteHold;

- (void)answer;			// Answers the call.
- (void)hangUp;			// Hangs-up the call.
// Attended call transfer. Sends REFER request to the receiver's remote party to initiate new INVITE session to the URL
// of |destinationCall|. The party at |destinationCall| then should replace the call with us with the new call from the
// REFER recipient.
- (void)attendedTransferToCall:(AKSIPCall *)destinationCall;
- (void)sendRingingNotification;			// Sends ringing notification to another party.
- (void)replyWithTemporarilyUnavailable;	// Replies with 480 Temporarily Unavailable.
- (void)replyWithBusyHere;					// Replies with 486 Busy Here.
- (void)ringbackStart;						// Starts local ringback sound.
- (void)ringbackStop;						// Stops local ringback sound.
- (void)sendDTMFDigits:(NSString *)digits;	// Sends DTMF.
- (void)muteMicrophone;						// Mutes microphone.
- (void)unmuteMicrophone;					// Unmutes microphone.
- (void)toggleMicrophoneMute;				// Toggles microphone mute.
- (void)hold;								// Places the call on hold.
- (void)unhold;								// Releases the call from hold.
- (void)toggleHold;							// Toggles call hold.

@end
