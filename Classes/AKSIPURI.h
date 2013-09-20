//
//  AKSIPURI.h
//  Telephone

#import <Foundation/Foundation.h>

// A class representing SIP URI.
@interface AKSIPURI : NSObject <NSCopying>

// SIP address in the form |user@host| or |host|.
@property (nonatomic, readonly, copy) NSString *SIPAddress;

// The receiver's display-name part.
@property (nonatomic, copy) NSString *displayName;

// The receiver's user part.
@property (nonatomic, copy) NSString *user;

// The receiver's password part.
@property (nonatomic, copy) NSString *password;

// The receiver's host part. Must not be nil.
@property (nonatomic, copy) NSString *host;

// The receiver's port part.
@property (nonatomic, assign) NSInteger port;

// The receiver's user parameter.
@property (nonatomic, copy) NSString *userParameter;

// The receiver's method parameter.
@property (nonatomic, copy) NSString *methodParameter;

// The receiver's transport parameter.
@property (nonatomic, copy) NSString *transportParameter;

// The receiver's TTL parameter.
@property (nonatomic, assign) NSInteger TTLParameter;

// The receiver's loose routing parameter.
@property (nonatomic, assign) NSInteger looseRoutingParameter;

// The receiver's maddr parameter.
@property (nonatomic, copy) NSString *maddrParameter;

// Creates and returns AKSIPURI object initialized with a specified user, host, and display name.
+ (id)SIPURIWithUser:(NSString *)aUser host:(NSString *)aHost displayName:(NSString *)aDisplayName;

// Creates and returns AKSIPURI object initialized with a provided string.
+ (id)SIPURIWithString:(NSString *)SIPURIString;

// Designated initializer.
// Initializes a AKSIPURI object with a specified user, host, and display name.
- (id)initWithUser:(NSString *)aUser host:(NSString *)aHost displayName:(NSString *)aDisplayName;

// Initializes a AKSIPURI object with a provided string.
- (id)initWithString:(NSString *)SIPURIString;

@end
