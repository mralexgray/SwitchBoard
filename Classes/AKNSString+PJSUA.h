//
//  AKNSString+PJSUA.h
//  Telephone

#import <Foundation/Foundation.h>
#import <pjsua-lib/pjsua.h>


@interface NSString (AKStringPJSUAAdditions)  			// A category for string conversions between NSString and PJSUA strings.

+ (NSString*) stringWithPJString:(pj_str_t)pjString;  	// Returns an NSString object created from a given PJSUA string.
-  (pj_str_t)  pjString;									// Returns PJSUA string created from the receiver.
+ (NSString*) uuidString;
@end
