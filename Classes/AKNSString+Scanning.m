//
//  AKNSString+Scanning.m
//  Telephone

#import "AKNSString+Scanning.h"

@implementation NSString (AKStringScanningAdditions)

- (BOOL)ak_isTelephoneNumber {
    NSPredicate *telephoneNumberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '\\\\+?\\\\d+'"];
	return ([telephoneNumberPredicate evaluateWithObject:self]) ? YES : NO;
}
- (BOOL)ak_hasLetters {
    NSPredicate *containsLettersPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '.*[a-zA-Z].*'"];
	return ([containsLettersPredicate evaluateWithObject:self]) ? YES : NO;
}
- (BOOL)ak_isIPAddress {
    NSPredicate *IPAddressPredicate
        = [NSPredicate predicateWithFormat:@"SELF MATCHES "
           "'\\\\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\\\."
           "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\\\."
           "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\\\."
           "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\\\b'"];
	return ([IPAddressPredicate evaluateWithObject:self]) ? YES : NO;
}

@end
