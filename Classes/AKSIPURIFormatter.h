//
//  AKSIPURIFormatter.h
//  Telephone

#import <Cocoa/Cocoa.h>

@class AKSIPURI;

// Instances of AKSIPURIFormatter create string representations of AKSIPURI, and convert textual representations of SIP
// URIs into AKSIPURI objects.
@interface AKSIPURIFormatter : NSFormatter

// A Boolean value indicating whether the receiver formats telephone numbers.
@property (nonatomic, assign) BOOL formatsTelephoneNumbers;

// A Boolean value indicating whether the receiver's telephone number formatter splits last four digits.
@property (nonatomic, assign) BOOL telephoneNumberFormatterSplitsLastFourDigits;

// Wrapper for |getObjectValue:forString:errorDescription:|. Returns AKSIPURI object converted from a given string.
- (AKSIPURI *)SIPURIFromString:(NSString *)SIPURIString;

@end
