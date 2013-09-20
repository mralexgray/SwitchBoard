//
//  AKABRecord+Querying.h
//  Telephone

#import <AddressBook/AddressBook.h>
#import <Foundation/Foundation.h>

// A category for querying Address Book record.
@interface ABRecord (AKRecordQueryingAdditions)

// Addressbook record's full name in the proper order or company name.
@property (nonatomic, readonly, copy) NSString *ak_fullName;

@end
