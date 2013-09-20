//
//  AKNSString+PJSUA.h
//  Telephone

#import <Foundation/Foundation.h>
#import <pjsua-lib/pjsua.h>

// A category for string conversions between NSString and PJSUA strings.
@interface NSString (AKStringPJSUAAdditions)

// Returns an NSString object created from a given PJSUA string.
+ (NSString *)stringWithPJString:(pj_str_t)pjString;

// Returns PJSUA string created from the receiver.
- (pj_str_t)pjString;

+ (NSString *)uuidString;
@end
