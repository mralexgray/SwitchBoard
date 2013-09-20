//
//  AKNetworkReachability.m
//  Telephone

#import "AKNetworkReachability.h"

#import <netinet/in.h>
#import <arpa/inet.h>

#import "AKNSString+Scanning.h"

NSString * const AKNetworkReachabilityDidBecomeReachableNotification = @"AKNetworkReachabilityDidBecomeReachable";
NSString * const AKNetworkReachabilityDidBecomeUnreachableNotification = @"AKNetworkReachabilityDidBecomeUnreachable";

// SCNetworkReachability callback.
static void AKReachabilityChanged(SCNetworkReachabilityRef target, SCNetworkConnectionFlags flags, void *info);

@interface AKNetworkReachability ()

@property (nonatomic, copy) NSString *host;

@end

@implementation AKNetworkReachability

- (BOOL)isReachable {
    SCNetworkConnectionFlags flags;
    Boolean flagsValid = SCNetworkReachabilityGetFlags(_reachability, &flags);
	return (flagsValid && (flags & kSCNetworkFlagsReachable)) ? YES : NO;
}

+ (AKNetworkReachability *)networkReachabilityWithHost:(NSString *)nameOrAddress {
    return [[[self alloc] initWithHost:nameOrAddress] autorelease];
}
- (id)initWithHost:(NSString *)nameOrAddress {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    if ([nameOrAddress length] == 0) {
        [self release];
        return nil;
    }
    
    if ([nameOrAddress ak_isIPAddress]) {
        struct sockaddr_in sin;
        bzero(&sin, sizeof(sin));
        sin.sin_len = sizeof(sin);
        sin.sin_family = AF_INET;
        inet_aton([nameOrAddress UTF8String], &sin.sin_addr);
        _reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (struct sockaddr *)&sin);
    } else {
        _reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [nameOrAddress UTF8String]);
    }
    
    _context.info = self;
    Boolean callbackSet = SCNetworkReachabilitySetCallback(_reachability, &AKReachabilityChanged, &_context);
    if (!callbackSet) {
        [self release];
        return nil;
    }
    
    Boolean scheduled = SCNetworkReachabilityScheduleWithRunLoop(_reachability,
                                                                 CFRunLoopGetMain(),
                                                                 kCFRunLoopDefaultMode);
    if (!scheduled) {
        [self release];
        return nil;
    }
    
    [self setHost:nameOrAddress];
	return self;
}
- (void)dealloc {
    SCNetworkReachabilityUnscheduleFromRunLoop(_reachability, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
    if (_reachability != NULL) {
        CFRelease(_reachability);
    }
    
    [_host release];
    
    [super dealloc];
}
- (NSString *)description {
    return [NSString stringWithFormat:@"%@ reachability", [self host]];
}

@end

static void AKReachabilityChanged(SCNetworkReachabilityRef target, SCNetworkConnectionFlags flags, void *info) {
    AKNetworkReachability *networkReachability = (AKNetworkReachability *)info;
    
    if (flags & kSCNetworkFlagsReachable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:AKNetworkReachabilityDidBecomeReachableNotification
                                                            object:networkReachability];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:AKNetworkReachabilityDidBecomeUnreachableNotification
                                                            object:networkReachability];
    }
}
