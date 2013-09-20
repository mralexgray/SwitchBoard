//
//  AKTelephoneNumberFormatter.h
//  Telephone

#import <Cocoa/Cocoa.h>

// Instances of AKTelephoneNumberFormatter create formatted telephone numbers from strings of contiguous digits, and
// convert strings with non-contiguous digits to strings that consist of contiguous digits only.
@interface AKTelephoneNumberFormatter : NSFormatter

// A Boolean value that determines whether the receiver should separate last two digits when formatting a telephone
// number. When YES, |+11234567890| becomes |+1 (123) 456-78-90|.
@property (nonatomic, assign) BOOL splitsLastFourDigits;

// Wrapper for |getObjectValue:forString:errorDescription:|. Scans |string| for numbers and returns them as a contiguous
// digits string.
- (NSString *)telephoneNumberFromString:(NSString *)string;

@end
