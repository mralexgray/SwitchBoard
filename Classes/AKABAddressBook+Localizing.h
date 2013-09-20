//
//  AKABAddressBook+Localizing.h
//  Telephone

#import <AddressBook/AddressBook.h>
#import <Foundation/Foundation.h>

// A category for localizing Address Book.
@interface ABAddressBook (AKAddressBookLocalizingAdditions)

// Returns localized label.
- (NSString *)ak_localizedLabel:(NSString *)label;

@end
