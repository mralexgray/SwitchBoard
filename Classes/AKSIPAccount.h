//
//  AKSIPAccount.h
//  Telephone

#import <Foundation/Foundation.h>
#import <pjsua-lib/pjsua.h>

// SIP account defaults.
extern const NSInteger kAKSIPAccountDefaultSIPProxyPort;
extern const NSInteger kAKSIPAccountDefaultReregistrationTime;

/** Notifications. */

// Posted when account registration changes.
extern NSString * const AKSIPAccountRegistrationDidChangeNotification;
//
// Posted when account is about to make call.
extern NSString * const AKSIPAccountWillMakeCallNotification;

@class AKSIPCall;

// Declares interface that AKSIPAccount delegate must implement.
@protocol AKSIPAccountDelegate
@optional
// Sent when AKSIPAccount receives an incoming call.
- (void)SIPAccountDidReceiveCall:(AKSIPCall *)aCall;
@end

@class AKSIPURI;

// A class representing a SIP account. It contains a list of calls and maintains SIP registration. You can use this
// class to make and receive calls.
@interface AKSIPAccount : NSObject

// The receiver's delegate.
@property (nonatomic, unsafe_unretained) NSObject <AKSIPAccountDelegate> *delegate;

// The URI for SIP registration.
// It is composed of |fullName| and |SIPAddress|, e.g. "John Smith" <john@company.com>
// TODO(eofster): strange property. Do we need this?
@property (nonatomic, copy) AKSIPURI *registrationURI;

// Full name of the registration URI.
@property (nonatomic, copy) NSString *fullName;

// SIP address of the registration URI.
@property (nonatomic, copy) NSString *SIPAddress;

// Registrar.
@property (nonatomic, copy) NSString *registrar;

// Realm. Pass nil to make a credential that can be used to authenticate against any challenges.
@property (nonatomic, copy) NSString *realm;

// Authentication user name.
@property (nonatomic, copy) NSString *username;

// SIP proxy host.
@property (nonatomic, copy) NSString *proxyHost;

// Network port to use with the SIP proxy.
// Default: 5060.
@property (nonatomic, assign) NSUInteger proxyPort;

// SIP re-registration time.
// Default: 300 (sec).
@property (nonatomic, assign) NSUInteger reregistrationTime;

// The receiver's identifier at the user agent.
@property (nonatomic, assign) NSInteger identifier;

// A Boolean value indicating whether the receiver is registered.
@property (nonatomic, assign, getter=isRegistered) BOOL registered;

// The receiver's SIP registration status code.
@property (nonatomic, readonly, assign) NSInteger registrationStatus;

// The receiver's SIP registration status text.
@property (nonatomic, readonly, copy) NSString *registrationStatusText;

// An up to date expiration interval for the receiver's registration session.
@property (nonatomic, readonly, assign) NSInteger registrationExpireTime;

// A Boolean value indicating whether the receiver is online in terms of SIP
// presence.
@property (nonatomic, assign, getter=isOnline) BOOL online;

// Presence online status text.
@property (nonatomic, readonly, copy) NSString *onlineStatusText;

// Calls that belong to the receiver.
@property (readonly, strong) NSMutableArray *calls;

// Creates and returns an AKSIPAccount object initialized with a given full name, SIP address, registrar, realm, and
// user name.
+ (id)SIPAccountWithFullName:(NSString *)aFullName
                  SIPAddress:(NSString *)aSIPAddress
                   registrar:(NSString *)aRegistrar
                       realm:(NSString *)aRealm
                    username:(NSString *)aUsername;

// Designated initializer.
// Initializes an AKSIPAccount object with a given full name, SIP address, registrar, realm, and user name.
- (id)initWithFullName:(NSString *)aFullName
            SIPAddress:(NSString *)aSIPAddress
             registrar:(NSString *)aRegistrar
                 realm:(NSString *)aRealm
              username:(NSString *)aUsername;

// Makes a call to a given destination URI.
- (AKSIPCall *)makeCallTo:(AKSIPURI *)destinationURI;

@end
