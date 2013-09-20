//
//  AKAddressBookPhonePlugIn.m
//  AKAddressBookPhonePlugIn

#import "AKAddressBookPhonePlugIn.h"

#import "AKABRecord+Querying.h"

@implementation AKAddressBookPhonePlugIn

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
    [_lastPhoneNumber release];
    [_lastFullName release];
    
    [super dealloc];
}

// This plug-in handles phone numbers.
- (NSString *)actionProperty {
    return kABPhoneProperty;
}
- (NSString *)titleForPerson:(ABPerson *)person identifier:(NSString *)identifier {
    NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.tlphn.TelephoneAddressBookPhonePlugIn"];
	return NSLocalizedStringFromTableInBundle(@"Dial with Telephone", nil, bundle, @"Action title.");
}
- (void)performActionForPerson:(ABPerson *)person identifier:(NSString *)identifier {
    NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bundleIdentifier == 'com.tlphn.Telephone'"];
    applications = [applications filteredArrayUsingPredicate:predicate];
    BOOL isTelephoneLaunched = [applications count] > 0;
    
    ABMultiValue *phones = [person valueForProperty:[self actionProperty]];
    NSString *phoneNumber = [phones valueForIdentifier:identifier];
    NSString *fullName = [person ak_fullName];
    
    if (!isTelephoneLaunched) {
        [[NSWorkspace sharedWorkspace] launchApplication:@"Telephone"];
        [self setShouldDial:YES];
        [self setLastPhoneNumber:phoneNumber];
        [self setLastFullName:fullName];
        
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  phoneNumber, @"AKPhoneNumber",
                                  fullName, @"AKFullName",
                                  nil];
        
        [[NSDistributedNotificationCenter defaultCenter]
         postNotificationName:AKAddressBookDidDialPhoneNumberNotification
                       object:@"AddressBook"
                     userInfo:userInfo];
    }
}
- (BOOL)shouldEnableActionForPerson:(ABPerson *)person identifier:(NSString *)identifier {
    return YES;
}
- (void)workspaceDidLaunchApplication:(NSNotification *)notification {
    NSRunningApplication *application = [[notification userInfo] objectForKey:NSWorkspaceApplicationKey];
    NSString *bundleIdentifier = [application bundleIdentifier];
    
    if ([bundleIdentifier isEqualToString:@"com.tlphn.Telephone"] && [self shouldDial]) {
        [self setShouldDial:NO];
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [self lastPhoneNumber], @"AKPhoneNumber",
                                  [self lastFullName], @"AKFullName",
                                  nil];
        
        [[NSDistributedNotificationCenter defaultCenter]
         postNotificationName:AKAddressBookDidDialPhoneNumberNotification
                       object:@"AddressBook"
                     userInfo:userInfo];
    }
}

@end
