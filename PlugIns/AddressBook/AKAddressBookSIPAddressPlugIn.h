//
//  AKAddressBookSIPAddressPlugIn.h
//  AKAddressBookSIPAddressPlugIn

#import <AddressBook/AddressBook.h>

// Object: @"AddressBook".
// Keys: @"AKSIPAddress", @"AKFullName".
NSString * const AKAddressBookDidDialSIPAddressNotification = @"AKAddressBookDidDialSIPAddress";

// An address book plug-in to dial SIP addresses with Telephone. SIP addresses are emails with a custom label |sip|.
@interface AKAddressBookSIPAddressPlugIn : NSObject

// SIP address that has been dialed last. While Telephone is being launched, several phone numbers can be dialed. We
// handle only the last one.
@property (nonatomic, copy) NSString *lastSIPAddress;

// Full name of the contact that has been dialed last. While Telephone is being launched, several phone numbers can be
// dialed. We handle only the last one.
@property (nonatomic, copy) NSString *lastFullName;

// A Boolean value that determines whether a call should be made after Telephone starts up.
@property (nonatomic, assign) BOOL shouldDial;

- (NSString *)actionProperty;

- (NSString *)titleForPerson:(ABPerson *)person identifier:(NSString *)identifier;

- (void)performActionForPerson:(ABPerson *)person identifier:(NSString *)identifier;

- (BOOL)shouldEnableActionForPerson:(ABPerson *)person identifier:(NSString *)identifier;

@end
