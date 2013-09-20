//
//  AKNSString+Scanning.h
//  Telephone

#import <Foundation/Foundation.h>

// A category for scanning strings.
@interface NSString (AKStringScanningAdditions)

// A Boolean value indicating whether the receiver is a telephone number, e.g. it consists of contiguous digits with
// an optional leading plus character.
@property (nonatomic, readonly, assign) BOOL ak_isTelephoneNumber;

// A Boolean value indicating whether the receiver consists only of a-z or A-Z.
@property (nonatomic, readonly, assign) BOOL ak_hasLetters;

// A Boolean value indicating whether the receiver is an IP address.
@property (nonatomic, readonly, assign) BOOL ak_isIPAddress;

@end
