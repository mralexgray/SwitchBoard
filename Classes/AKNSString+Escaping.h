//
//  AKNSString+Escaping.h
//  Telephone


#import <Foundation/Foundation.h>

// A category for escaping strings.
@interface NSString (AKStringEscapingAdditions)

// Returns a new string created from the receiver where every occurrence of the first character from a given string is
// escaped with a backslash.
- (NSString *)ak_escapeFirstCharacterFromString:(NSString *)string;

// Returns a new string created from the receiver where every quote character, i.e. |"|, is escaped with a backslash.
- (NSString *)ak_escapeQuotes;

// Returns a new string created from the receiver where every parenthesis, i.e. |(| or |)|, is escaped with a backslash.
- (NSString *)ak_escapeParentheses;

@end
