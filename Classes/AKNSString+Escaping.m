//
//  AKNSString+Escaping.m
//  Telephone


#import "AKNSString+Escaping.h"

@implementation NSString (AKStringEscapingAdditions)

- (NSString *)ak_escapeFirstCharacterFromString:(NSString *)string {
    NSMutableString *newString = [NSMutableString stringWithString:self];
    NSString *escapeCharacterString = [string substringWithRange:NSMakeRange(0, 1)];
    NSRange escapeCharacterRange = [newString rangeOfString:escapeCharacterString];
    while (escapeCharacterRange.location != NSNotFound) {
        [newString insertString:@"\\" atIndex:escapeCharacterRange.location];
        NSRange searchRange;
        searchRange.location = escapeCharacterRange.location + 2;
        searchRange.length = [newString length] - searchRange.location;
        escapeCharacterRange = [newString rangeOfString:escapeCharacterString options:0 range:searchRange];
    }
	return [newString copy];
}
- (NSString *)ak_escapeQuotes {
    return [self ak_escapeFirstCharacterFromString:@"\""];
}
- (NSString *)ak_escapeParentheses {
    NSString *returnString = [self ak_escapeFirstCharacterFromString:@")"];
	return [returnString ak_escapeFirstCharacterFromString:@"("];
}

@end
