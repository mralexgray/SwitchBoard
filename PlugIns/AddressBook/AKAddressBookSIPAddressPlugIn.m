//
//  AKAddressBookSIPAddressPlugIn.m
//  AKAddressBookSIPAddressPlugIn

#import "AKAddressBookSIPAddressPlugIn.h"

#import "AKABRecord+Querying.h"

@implementation AKAddressBookSIPAddressPlugIn

- (id)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
	[self setShouldDial:NO];
	NSNotificationCenter *notificationCenter = [[NSWorkspace sharedWorkspace] notificationCenter];
	[notificationCenter addObserver:self
                           selector:@selector(workspaceDidLaunchApplication:)
                               name:NSWorkspaceDidLaunchApplicationNotification
                             object:nil];
	return self;
}
- (void)dealloc {
    [_lastSIPAddress release];
    [_lastFullName release];
	[super dealloc];
}

// This plug-in handles emails.
- (NSString *)actionProperty {
    return kABEmailProperty;
}
- (NSString *)titleForPerson:(ABPerson *)person identifier:(NSString *)identifier {
    NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.tlphn.TelephoneAddressBookSIPAddressPlugIn"];
	return NSLocalizedStringFromTableInBundle(@"Dial with Telephone", nil, bundle, @"Action title.");
}
- (void)performActionForPerson:(ABPerson *)person identifier:(NSString *)identifier {
    NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bundleIdentifier == 'com.tlphn.Telephone'"];
    applications = [applications filteredArrayUsingPredicate:predicate];
    BOOL isTelephoneLaunched = [applications count] > 0;
	ABMultiValue *emails = [person valueForProperty:[self actionProperty]];
    NSString *anEmail = [emails valueForIdentifier:identifier];
    NSString *fullName = [person ak_fullName];
	if (!isTelephoneLaunched) {
        [[NSWorkspace sharedWorkspace] launchApplication:@"Telephone"];
        [self setShouldDial:YES];
        [self setLastSIPAddress:anEmail];
        [self setLastFullName:fullName];
        
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  anEmail, @"AKSIPAddress",
                                  fullName, @"AKFullName",
                                  nil];
        
        [[NSDistributedNotificationCenter defaultCenter]
         postNotificationName:AKAddressBookDidDialSIPAddressNotification
                       object:@"AddressBook"
                     userInfo:userInfo];
    }
}
- (BOOL)shouldEnableActionForPerson:(ABPerson *)person identifier:(NSString *)identifier {
    ABMultiValue *emails = [person valueForProperty:[self actionProperty]];
    NSString *label = [emails labelForIdentifier:identifier];
	// Enable the action only if label is |sip|.
    if ([label caseInsensitiveCompare:@"sip"] == NSOrderedSame) {
        return YES;
    } else {
        return NO;
    }
}
- (void)workspaceDidLaunchApplication:(NSNotification *)notification {
    NSRunningApplication *application = [[notification userInfo] objectForKey:NSWorkspaceApplicationKey];
    NSString *bundleIdentifier = [application bundleIdentifier];
	if ([bundleIdentifier isEqualToString:@"com.tlphn.Telephone"] && [self shouldDial]) {
        [self setShouldDial:NO];
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [self lastSIPAddress], @"AKSIPAddress",
                                  [self lastFullName], @"AKFullName",
                                  nil];
        
        [[NSDistributedNotificationCenter defaultCenter]
         postNotificationName:AKAddressBookDidDialSIPAddressNotification
                       object:@"AddressBook"
                     userInfo:userInfo];
    }
}

@end
