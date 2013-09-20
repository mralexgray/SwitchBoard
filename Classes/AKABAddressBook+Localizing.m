//
//  AKABAddressBook+Localizing.m
//  Telephone

#import "AKABAddressBook+Localizing.h"

#import <AddressBook/ABAddressBookC.h>

@implementation ABAddressBook (AKAddressBookLocalizingAdditions)

- (NSString *)ak_localizedLabel:(NSString *)label {
    NSString *theString;
	if ([label isEqualToString:kABPhoneWorkLabel]) {
        theString = NSLocalizedStringFromTable(@"work", @"AddressBookLabels", @"Work phone number.");
    } else if ([label isEqualToString:kABPhoneHomeLabel]) {
        theString = NSLocalizedStringFromTable(@"home", @"AddressBookLabels", @"Home phone number.");
    } else if ([label isEqualToString:kABPhoneMobileLabel]) {
        theString = NSLocalizedStringFromTable(@"mobile", @"AddressBookLabels", @"Mobile phone number.");
    } else if ([label isEqualToString:kABPhoneMainLabel]) {
        theString = NSLocalizedStringFromTable(@"main", @"AddressBookLabels", @"Main phone number.");
    } else if ([label isEqualToString:kABPhoneHomeFAXLabel]) {
        theString = NSLocalizedStringFromTable(@"home fax", @"AddressBookLabels", @"Home FAX number.");
    } else if ([label isEqualToString:kABPhoneWorkFAXLabel]) {
        theString = NSLocalizedStringFromTable(@"work fax", @"AddressBookLabels", @"Work FAX number.");
    } else if ([label isEqualToString:kABPhonePagerLabel]) {
        theString = NSLocalizedStringFromTable(@"pager", @"AddressBookLabels", @"Pager number.");
    } else if ([label isEqualToString:kABOtherLabel]) {
        theString = NSLocalizedStringFromTable(@"other", @"AddressBookLabels", @"Other number.");
    } else if ([label isEqualToString:@"sip"]) {
        theString = NSLocalizedStringFromTable(@"sip", @"AddressBookLabels", @"SIP address.");
    } else {
	        CFStringRef localizedLabel = ABCopyLocalizedPropertyOrLabel((__bridge CFStringRef)label);
	        theString = (__bridge_transfer NSString *)localizedLabel;
    }
	return theString;
}

@end
