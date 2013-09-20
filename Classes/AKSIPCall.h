//
//  AKSIPCall.h
//  Telephone

#import <Foundation/Foundation.h>
#import <pjsua-lib/pjsua.h>

extern const NSInteger kAKSIPCallsMax;

enum {
    // Before INVITE is sent or received.
    kAKSIPCallNullState =         PJSIP_INV_STATE_NULL,
    
    // After INVITE is sent.
    kAKSIPCallCallingState =      PJSIP_INV_STATE_CALLING,
    
    // After INVITE is received.
    kAKSIPCallIncomingState =     PJSIP_INV_STATE_INCOMING,
    
    // After response with To tag.
    kAKSIPCallEarlyState =        PJSIP_INV_STATE_EARLY,
    
    // After 2xx is sent/received.
    kAKSIPCallConnectingState =   PJSIP_INV_STATE_CONNECTING,
    
    // After ACK is sent/received.
    kAKSIPCallConfirmedState =    PJSIP_INV_STATE_CONFIRMED,
    
    // Session is terminated.
    kAKSIPCallDisconnectedState = PJSIP_INV_STATE_DISCONNECTED
};
typedef NSUInteger AKSIPCallState;

// Notifications.
//
// Calling. After INVITE is sent.
extern NSString * const AKSIPCallCallingNotification;
//
// Incoming. After INVITE is received.
// Delegate is not subscribed to this notification.
extern NSString * const AKSIPCallIncomingNotification;
//
// Early. After response with To tag.
// Keys: @"AKSIPEventCode", @"AKSIPEventReason".
extern NSString * const AKSIPCallEarlyNotification;
//
// Connecting. After 2xx is sent/received.
extern NSString * const AKSIPCallConnectingNotification;
//
// Confirmed. After ACK is sent/received.
extern NSString * const AKSIPCallDidConfirmNotification;
//
// Disconnected. Session is terminated.
extern NSString * const AKSIPCallDidDisconnectNotification;
//
// Call media is active.
extern NSString * const AKSIPCallMediaDidBecomeActiveNotification;
//
// Call media is put on hold by local endpoint.
extern NSString * const AKSIPCallDidLocalHoldNotification;
//
// Call media is put on hold by remote endpoint.
extern NSString * const AKSIPCallDidRemoteHoldNotification;
//
// Call transfer status changed.
// Key: @"AKFinalTransferNotification".
extern NSString * const AKSIPCallTransferStatusDidChangeNotification;

@class AKSIPAccount, AKSIPURI, AKSIPCallMediaFlow;

// A class representing a SIP call.
@interface AKSIPCall : NSObject

// The receiver's delegate.
@property (nonatomic, unsafe_unretained) id delegate;

// The receiver's identifier.
@property (nonatomic, assign) NSInteger identifier;

// SIP URI of the local Contact header.
@property (nonatomic, copy) AKSIPURI *localURI;

// SIP URI of the remote Contact header.
@property (nonatomic, copy) AKSIPURI *remoteURI;

// Call state.
@property (assign) AKSIPCallState state;

// Call state text.
@property (copy) NSString *stateText;

// Call's last status code.
@property (assign) NSInteger lastStatus;

// Call's last status text.
@property (copy) NSString *lastStatusText;

// Call transfer status code.
@property (assign) NSInteger transferStatus;

// Call transfer status text.
@property (copy) NSString *transferStatusText;

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

// The account the call belongs to.
@property (nonatomic, weak) AKSIPAccount *account;

@property (nonatomic, strong) AKSIPCallMediaFlow *mediaFlow;

// Designated initializer.
// Initializes a AKSIPCall object with a given SIP account and identifier.
- (id)initWithSIPAccount:(AKSIPAccount *)anAccount
              identifier:(NSInteger)anIdentifier;

// Answers the call.
- (void)answer;

// Hangs-up the call.
- (void)hangUp;

// Attended call transfer. Sends REFER request to the receiver's remote party to initiate new INVITE session to the URL
// of |destinationCall|. The party at |destinationCall| then should replace the call with us with the new call from the
// REFER recipient.
- (void)attendedTransferToCall:(AKSIPCall *)destinationCall;

// Sends ringing notification to another party.
- (void)sendRingingNotification;

// Replies with 480 Temporarily Unavailable.
- (void)replyWithTemporarilyUnavailable;

// Replies with 486 Busy Here.
- (void)replyWithBusyHere;

// Starts local ringback sound.
- (void)ringbackStart;

// Stops local ringback sound.
- (void)ringbackStop;

// Sends DTMF.
- (void)sendDTMFDigits:(NSString *)digits;

// Mutes microphone.
- (void)muteMicrophone;

// Unmutes microphone.
- (void)unmuteMicrophone;

// Toggles microphone mute.
- (void)toggleMicrophoneMute;

// Places the call on hold.
- (void)hold;

// Releases the call from hold.
- (void)unhold;

// Toggles call hold.
- (void)toggleHold;

- (void) record;
- (void) play;
- (void) say:(NSString*) words;

@end
