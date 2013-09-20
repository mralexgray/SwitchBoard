//
//  AKAddressBookPhonePlugIn.h
//  AKAddressBookPhonePlugIn

#import <AddressBook/AddressBook.h>

// Object: @"AddressBook".
// Keys: @"AKPhoneNumber", @"AKFullName".
NSString * const AKAddressBookDidDialPhoneNumberNotification = @"AKAddressBookDidDialPhoneNumber";

// An Address Book plug-in to dial phone numbers with Telephone.
@interface AKAddressBookPhonePlugIn : NSObject

// Phone number that has been dialed last. While Telephone is being launched, several phone numbers can be dialed. We
// handle only the last one.
@property (nonatomic, copy) NSString *lastPhoneNumber;

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
