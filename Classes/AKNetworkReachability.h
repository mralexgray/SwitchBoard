//
//  AKNetworkReachability.h
//  Telephone

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

// Notifications.
//
// Sent when target host becomes reachable.
extern NSString * const AKNetworkReachabilityDidBecomeReachableNotification;
//
// Sent when target host becomes unreachable.
extern NSString * const AKNetworkReachabilityDidBecomeUnreachableNotification;

// Wrapper for SCNetworkReachability.
@interface AKNetworkReachability : NSObject {
  @private
    SCNetworkReachabilityRef _reachability;  // Strong.
    SCNetworkReachabilityContext _context;
}

// Host name or address of the target host.
@property (nonatomic, readonly, copy) NSString *host;

// A Boolean value indicating whether the target host is reachable.
@property (nonatomic, readonly, assign, getter=isReachable) BOOL reachable;

// Returns a new instance of the network reachability for the given host.
// Returns nil when |nameOrAddress| is nil or @"".
+ (AKNetworkReachability *)networkReachabilityWithHost:(NSString *)nameOrAddress;

// Designated initializer.
// Returns nil when |nameOrAddress| is nil or @"".
- (id)initWithHost:(NSString *)nameOrAddress;

@end
